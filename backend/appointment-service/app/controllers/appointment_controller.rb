class AppointmentController < ApplicationController
    
    def initialize
        @appointmentUtility = AppointmentUtility.new
    end

    def index
        # TODO: Show all appointments for corresponding patient and doctor
        # BLOCKED: User authorization is required.
    end
    
    def create
        # TODO: Create appointment for patient or doctor
        request_body = appointment_param
        appointment = @appointmentUtility.create(request_body[:patient_id], request_body[:doctor_id], request_body[:start_time], request_body[:end_time], true)
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
        # TODO: Delete corresponding appointment
        # BLOCKED: User authorization is required.
    end

    private
    def appointment_param
        params[:appointment].permit(:patient_id, :doctor_id, :start_time, :end_time)
    end
end