class AppointmentMailer < ApplicationMailer
    layout 'mailer'
    def new_appointment_email
        @appointment = params[:appointment]
        email = params[:email]
        mail(to: email, subject: "Scheduled a new appointment with Appointment and TeleVisit Service")
    end

    def cancel_appointment_email
        @appointment = params[:appointment]
        email = params[:email]
        mail(to: email, subject: "Cancelled a appointment with Appointment and TeleVisit Service", template_name: "cancel_appointment_email")
    end
end
