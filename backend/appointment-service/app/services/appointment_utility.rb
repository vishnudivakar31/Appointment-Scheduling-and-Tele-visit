require 'rest-client'

class AppointmentUtility
    module APPOINTMENT_STATUS
        PENDING = 0
        ACTIVE = 1
        ENDED = 2
        CANCELLED = 3
    end
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