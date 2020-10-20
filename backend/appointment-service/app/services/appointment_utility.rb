class AppointmentUtility
    module APPOINTMENT_STATUS
        PENDING = 0
        ACTIVE = 1
        ENDED = 2
        CANCELLED = 3
    end
    def create(patient_id, doctor_id, start_time, end_time, tele_visit_status)
        appointment = Appointment.new(patient_id: patient_id, doctor_id: doctor_id, start_time: start_time, end_time: end_time, appointment_status: APPOINTMENT_STATUS::PENDING)
        # TODO: Create tele-visit session accordingly
        appointment.save
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
end