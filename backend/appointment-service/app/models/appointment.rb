class Appointment < ApplicationRecord
    validates :patient_id, :start_time, :end_time, :doctor_id, :appointment_status, presence: true
    validates_with AppointmentValidator
    has_many :charts
    has_one :consultationSummary
end

class AppointmentValidator < ActiveModel::Validator
    def validate(model)
        if model.end_time.to_time.to_i <= model.start_time.to_time.to_i
            model.errors[:base] << "end date and time should be greater than start date and time"
        end
    end
end