class Appointment < ApplicationRecord
    has_many :charts
    has_one :consultationSummary
end
