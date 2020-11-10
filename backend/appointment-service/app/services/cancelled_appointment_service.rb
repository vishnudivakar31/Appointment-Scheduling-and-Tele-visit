class CancelledAppointmentService
    def show(patient_id, doctor_id, from, to, appointment_id)
        if patient_id
            appointments = CancelledByPatient.where("patient_id = ?", patient_id)
        else
            appointments = CancelledByPractice.where("doctor_id = ?", doctor_id)
        end

        if from
            appointments = appointments.select {|appointment| appointment.created_at.to_date >= from.to_date}
        end
        if to
            appointments = appointments.select {|appointment| appointment.created_at.to_date <= to.to_date}
        end
        if appointment_id
            appointments = appointments.select {|appointment| appointment.appointment_id === appointment_id.to_i}
        end
        appointments.sort {|a, b| a.created_at.to_date <=> b.created_at.to_date}
        appointments
    end

end