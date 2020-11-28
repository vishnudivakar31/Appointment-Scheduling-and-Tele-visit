class AppointmentMailer < ApplicationMailer
    layout 'mailer'
    def new_appointment_email
        @appointment = params[:appointment]
        mail.attachments['event.ics'] = { mime_type: 'text/calendar', 
            content: generate_calendar_event("Doctor Appointment", @appointment.start_time, @appointment.end_time, 'REQUEST', nil, "UID_#{@appointment.id}_email").to_ical }
        email = params[:email]
        mail(to: email, subject: "Scheduled a new appointment with Appointment and TeleVisit Service")
    end

    def cancel_appointment_email
        @appointment = params[:appointment]
        mail.attachments['event.ics'] = { mime_type: 'text/calendar', 
            content: generate_calendar_event("Doctor Appointment Cancelled", @appointment.start_time, @appointment.end_time, 'CANCEL', 'CANCELLED', "UID_#{@appointment.id}_email").to_ical }
        email = params[:email]
        mail(to: email, subject: "Cancelled a appointment with Appointment and TeleVisit Service", template_name: "cancel_appointment_email")
    end

    private
    def generate_calendar_event(description_text, start_date, end_date, method, status, uid)
        sequence_number = 0
        if status != nil
            sequence_number = 1
        end
        ical = Icalendar::Calendar.new
        ical.event do |e| 
            e.dtstart = Icalendar::Values::DateTime.new(start_date)
            e.dtend = Icalendar::Values::DateTime.new(end_date)
            e.summary = "Doctor Appointment"
            e.location = "https://group2-patient-portal.herokuapp.com/appointments"
            if status === nil
                e.alarm do |a|
                    a.action = "AUDIO"
                    a.trigger = "-PT15M"
                    a.append_attach "Basso"
                end
            end
        end
        ical.append_custom_property('UID', uid)
        ical.append_custom_property('SEQUENCE', sequence_number.to_s)
        ical.append_custom_property('METHOD', method)
        ical.append_custom_property('STATUS', status) if status != nil
        ical
    end
end
