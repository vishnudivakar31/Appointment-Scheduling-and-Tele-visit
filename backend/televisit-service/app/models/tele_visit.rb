class TeleVisit < ApplicationRecord
    validates :appointment_id, :session_id, :patient_token, :doctor_token, :status, presence: true
end
