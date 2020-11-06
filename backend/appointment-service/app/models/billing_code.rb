class BillingCode < ApplicationRecord
    validates :code, :appointment_id, presence: true
    belongs_to :appointment
end
