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
end