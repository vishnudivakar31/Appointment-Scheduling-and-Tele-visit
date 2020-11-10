class CancelledAppointmentController < ApplicationController
    def initialize
      @cancelled_appointment_service = CancelledAppointmentService.new
    end

    def show
        patient_id = params[:patient_id]
        doctor_id = params[:doctor_id]
        from = params[:from]
        to = params[:to]
        appointment_id = params[:appointment_id]
        if patient_id === nil && doctor_id === nil
            render json: {message: 'patient_id or doctor_id is required'}, status: 500
        else
            appointments = @cancelled_appointment_service.show(patient_id, doctor_id, from, to, appointment_id)
            if appointments
                render json: appointments, status: 200
            else
                render json: {message: 'no appointments'}, status: 500
            end
        end
    end
end