class AppointmentController < ApplicationController
    
    def initialize
        @appointmentUtility = AppointmentUtility.new
    end

    def index
        # TODO: Show all appointments for corresponding patient and doctor
    end
    
    def create
        # TODO: Create appointment for patient or doctor
        byebug
        request_body = appointment_param
        appointment = @appointmentUtility.create(request_body[:patient_id], request_body[:doctor_id], request_body[:start_time], request_body[:end_time], true)
        if appointment && appointment.errors.full_messages.length === 0
            render json: appointment, status: 201
        else
            render json: {message: appointment.errors.full_messages}, status: 500
        end
    end

    def show
        # TODO: Show corresponding appointment
    end

    def update
        # TODO: Update corresponding appointment
    end

    def destroy
        # TODO: Delete corresponding appointment
    end

    private
    def appointment_param
        params[:appointment].permit(:patient_id, :doctor_id, :start_time, :end_time)
    end
end