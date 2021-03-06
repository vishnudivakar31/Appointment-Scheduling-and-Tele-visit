class AppointmentController < ApplicationController
    
    def initialize
        @appointmentUtility = AppointmentUtility.new
    end

    def index
        patient_id = params[:patient_id]
        doctor_id = params[:doctor_id]
        from = params[:from]
        to = params[:to]
        appointment_status = params[:appointment_status]
        if patient_id
            appointments = @appointmentUtility.all_appointments('patient', patient_id, from, to, appointment_status)
        end
        if doctor_id
            appointments = @appointmentUtility.all_appointments('doctor', doctor_id, from, to, appointment_status)
        end
        if appointments
            render json: appointments, status: 200
        elsif patient_id === nil && doctor_id === nil
            render json: {message: 'patient_id or doctor_id is required'}, status: 500
        else
            render json: {message: 'no appointments'}, status: 500
        end
    end
    
    def create
        request_body = appointment_param
        email = params[:email]
        appointment = @appointmentUtility.create(request_body[:patient_id], request_body[:doctor_id], request_body[:start_time], request_body[:end_time], params[:tele_visit], email)
        if appointment && appointment.errors.full_messages.length === 0
            render json: appointment, status: 201
        else
            render json: {message: appointment.errors.full_messages}, status: 500
        end
    end

    def show
        appointment = @appointmentUtility.show(params[:id])
        if appointment && appointment.errors.full_messages.length === 0
            render json: appointment, status: 200
        else
            render json: {message: appointment.errors.full_messages}, status: 500
        end
    end

    def update
        appointment = @appointmentUtility.update_status(params[:id], params[:appointment_status])
        if appointment && appointment.errors.full_messages.length === 0
            render json: appointment, status: 200
        else
            render json: {message: appointment.errors.full_messages}, status: 500
        end
    end

    def destroy
        patient_id = params[:patient_id]
        doctor_id = params[:doctor_id]
        email = params[:email]
        if patient_id
            appointment = @appointmentUtility.cancel_appointments('patient', params[:id], patient_id, params[:cancel_reason], email)
        end
        if doctor_id
            appointment = @appointmentUtility.cancel_appointments('doctor', params[:id], doctor_id, params[:cancel_reason], email)
        end
        if appointment
            render json: appointment, status: 200
        elsif patient_id === nil && doctor_id === nil
            render json: {message: 'patient_id or doctor_id is required.'}, status: 500
        else
            render json: {message: 'no appointment with this id'}, status: 500
        end
    end

    def upload_charts
        appointment = @appointmentUtility.upload_chart(params[:id], params, params[:files_count])
        if appointment && appointment.errors.full_messages.length === 0
            render json: appointment.charts, status: 200
        else
            render json: {message: appointment.errors.full_messages}, status: 500
        end
    end

    def get_charts
        appointment = @appointmentUtility.get_charts(params[:id])
        if appointment && appointment.errors.full_messages.length === 0
            render json: appointment.charts, status: 200
        else
            render json: {message: appointment.errors.full_messages}, status: 500
        end
    end

    def get_charts_by_id
        file = @appointmentUtility.get_charts_by_id(params[:id], params[:chart_id].to_i)
        if file
            send_file file[:path], :disposition => 'attachement', :filename => file[:name]
        else
            render json: {message: 'no file present to download'}, status: 500
        end
    end

    def upload_summary
        appointment = @appointmentUtility.upload_summary(params[:id], params[:file])
        if appointment && appointment.errors.full_messages.length === 0
            render json: appointment.consultationSummary, status: 200
        else
            render json: {message: appointment.errors.full_messages}, status: 500
        end
    end

    def upload_summary_text
        appointment = @appointmentUtility.upload_summary_text(params[:id], params[:summary])
        if appointment && appointment.errors.full_messages.length === 0
            render json: appointment.consultationSummary, status: 200
        else
            render json: {message: appointment.errors.full_messages}, status: 500
        end
    end

    def download_summary
        type = params[:download_type]
        file = @appointmentUtility.download_summary(params[:id])
        if file && type === 'file'
            send_file file[:path], :disposition => 'attachement', :filename => file[:name]
        elsif file && type === 'json'
            data = ''
            f = File.open(file[:path], 'r')
            f.each_line {|line| data += line}
            render json: {summary: data}, status: 200
        else
            render json: {message: 'no file present to download'}, status: 500
        end
    end

    def create_billing_codes
        billing_codes = params[:billing_codes]
        id = params[:id]
        response = @appointmentUtility.create_billing_codes(id, billing_codes)
        if response
            render json: response
        else
            render json: {message: 'error in saving billing codes'}, status: 500
        end
    end

    def get_billing_codes
        response = @appointmentUtility.get_billing_codes(params[:id])
        if response
            render json: response
        else
            render json: {message: 'error in fetching billing codes'}, status: 500
        end
    end

    def report
        report = @appointmentUtility.generate_report(params[:id])
        if report
            render json: report
        else
            render json: {message: 'no appointment'}, status: 500
        end
    end

    private
    def appointment_param
        params[:appointment].permit(:patient_id, :doctor_id, :start_time, :end_time)
    end
end