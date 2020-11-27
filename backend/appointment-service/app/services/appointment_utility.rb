require 'rest-client'

class AppointmentUtility
    module APPOINTMENT_STATUS
        PENDING = 0
        ACTIVE = 1
        ENDED = 2
        CANCELLED = 3
    end

    module CONSTANTS
        TELE_VISIT_URL = 'https://televisit-service.herokuapp.com/televisit'
    end

    APPOINTMENT_STATUS_LABEL = ['PENDING', 'ACTIVE', 'ENDED', 'CANCELLED']

    def create(patient_id, doctor_id, start_time, end_time, tele_visit_status)
        appointment = Appointment.new(patient_id: patient_id, doctor_id: doctor_id, start_time: start_time, end_time: end_time, appointment_status: APPOINTMENT_STATUS::PENDING)
        appointment.save
        if tele_visit_status.to_s.downcase === 'true'
            response = RestClient.post CONSTANTS::TELE_VISIT_URL, {appointment_id: appointment.appointment_id}
            if response.code != 201
                appointment.destroy
                appointment.errors.add(:appointment_status, JSON.parse(response))
            end
        end
        appointment
    end
    def show(id)
        appointment = Appointment.find(id)
        appointment
    end
    def update_status(id, status)
        appointment = Appointment.find(id)
        status = status.to_i
        if status == APPOINTMENT_STATUS::ACTIVE && appointment.appointment_status === APPOINTMENT_STATUS::PENDING
            appointment.appointment_status = APPOINTMENT_STATUS::ACTIVE
            appointment.save
            return appointment
        elsif status == APPOINTMENT_STATUS::ENDED && (appointment.appointment_status === APPOINTMENT_STATUS::PENDING || appointment.appointment_status === APPOINTMENT_STATUS::ACTIVE)
            appointment.appointment_status = APPOINTMENT_STATUS::ENDED
            appointment.save
            return appointment
        end
        appointment.errors.add(:appointment_status, "status can't be updated, possible reasons: trying to bring down appointment status or trying to cancel the appointment")
        appointment
    end

    def upload_chart(id, params, file_count)
        file_paths = []
        appointment = Appointment.find(id)
        for i in 1..file_count.to_i
            file = params["file#{i}"]
            file_paths << store_file(id, file, 'chart')
        end
        file_paths.each do |file|
            chart = Chart.new(file_path: file, appointment_id: id)
            appointment.charts << chart
        end
        appointment
    end

    def get_charts(id)
        appointment = Appointment.find(id)
        appointment
    end

    def get_charts_by_id(id, chart_id)
        file = nil
        appointment = Appointment.find(id)
        appointment.charts.each do |chart|
            if chart.id === chart_id
                file = {}
                file[:path] = chart.file_path
                file[:name] = String.new chart.file_path
                file[:name].sub!("storage/#{id}_chart_", '')
            end
        end
        file
    end

    def upload_summary(id, upload_file)
        appointment = Appointment.find(id)
        file_path = store_file(id, upload_file, 'summary')
        summary = ConsultationSummary.new(appointment_id: id, file_path: file_path)
        appointment.consultationSummary = summary
        appointment.save
        appointment
    end

    def download_summary(id)
        file = nil
        appointment = Appointment.find(id)
        if appointment && appointment.consultationSummary 
            file = {}
            file[:path] = appointment.consultationSummary.file_path
            file[:name] = String.new appointment.consultationSummary.file_path
            file[:name].sub!("storage/#{id}_summary_", '')
        end
        file
    end

    def create_billing_codes(id, codes)
        appointment = Appointment.find(id)
        codes.split(",").each do |code|
            codeModel = BillingCode.new(code: code, appointment_id: id)
            appointment.billingCodes << codeModel
        end
        appointment.billingCodes
    end

    def get_billing_codes(id)
        appointment = Appointment.find(id)
        appointment.billingCodes
    end

    def generate_report(id)
        report = {}
        appointment = Appointment.find(id)
        if appointment
            report[:appointment] = appointment
            report[:charts] = appointment.charts
            report[:consultationSummary] = appointment.consultationSummary
            report[:billingCodes] = appointment.billingCodes
            report[:appointment_duration] = {duration: appointment.end_time.to_time.to_i - appointment.start_time.to_time.to_i, unit: 'seconds'}
            if appointment.appointment_status === APPOINTMENT_STATUS::CANCELLED
                cancelled_appointment = CancelledByPatient.find(id)
                if cancelled_appointment === nil
                    cancelled_appointment = CancelledByPractice.find(id)
                end
                report[:cancelled_appointment] = cancelled_appointment
            end
            begin
                response = RestClient.get "#{CONSTANTS::TELE_VISIT_URL}?appointment_id=#{appointment.appointment_id}"
                televisit_response = JSON.parse(response)
                if response.code === 200
                    report[:tele_visit] = {visit: televisit_response}
                    if televisit_response["started_at"] && televisit_response["ended_at"]
                        report[:tele_visit][:televisit_duration] = { duration: televisit_response["ended_at"].to_time.to_i - televisit_response["started_at"].to_time.to_i, unit: 'seconds'}
                    end
                end
            rescue => ex
                ex
            end
            return report
        end
        return nil
    end

    def all_appointments(user_type, id, from, to, appointment_status)
        if user_type.downcase === 'patient'
            appointments = Appointment.where("patient_id = ?", id)
        else
            appointments = Appointment.where("doctor_id = ?", id)
        end
        if from
            appointments = appointments.select {|appointment| appointment.start_time.to_date >= from.to_date}
        end
        if to
            appointments = appointments.select {|appointment| appointment.end_time.to_date <= to.to_date}
        end
        if appointment_status
            appointments = appointments.select {|appointment| appointment.appointment_status === appointment_status.to_i}
        end
        appointments.sort {|a, b| a.start_time.to_date <=> b.start_time.to_date}
        appointments
    end

    def cancel_appointments(user_type, id, user_id, cancel_reason)
        user_id = user_id.to_i
        appointment = Appointment.find(id)
        if appointment && user_type.downcase === 'patient'
            if appointment.patient_id === user_id && appointment.appointment_status != APPOINTMENT_STATUS::CANCELLED
                begin
                    RestClient.delete "#{CONSTANTS::TELE_VISIT_URL}/#{id}"
                rescue ex =>
                    ex
                end
                appointment.appointment_status = APPOINTMENT_STATUS::CANCELLED
                appointment.save
                cancelled_by_patient = CancelledByPatient.new(appointment_id: id, cancel_reason: cancel_reason, patient_id: user_id)
                cancelled_by_patient.save
                return cancelled_by_patient
            end
        elsif appointment && user_type.downcase === 'doctor' && appointment.appointment_status != APPOINTMENT_STATUS::CANCELLED
            if appointment.doctor_id === user_id
                begin
                    RestClient.delete "#{CONSTANTS::TELE_VISIT_URL}/#{id}"
                rescue ex =>
                    ex
                end
                appointment.appointment_status = APPOINTMENT_STATUS::CANCELLED
                appointment.save
                cancelled_by_practice = CancelledByPractice.new(appointment_id: id, cancel_reason: cancel_reason, doctor_id: user_id)
                cancelled_by_practice.save
                return cancelled_by_practice
            end
        end
        return nil
    end

    private
    def store_file(id, file, type)
        new_file = File.new("storage/#{id}_#{type}_#{file.original_filename}", 'w')
        file_path = new_file.path
        content = file.tempfile.read
        content = content.force_encoding('UTF-8')
        new_file.write(content)
        new_file.close
        file_path
    end
end