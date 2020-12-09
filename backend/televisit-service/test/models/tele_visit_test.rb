require 'test_helper'

class TeleVisitTest < ActiveSupport::TestCase
  test 'TeleVisit Model Validity: creating a valid televisit model' do
    visit = TeleVisit.create(appointment_id: 99999, session_id: 1213123, patient_token: 12312, doctor_token: 2312, status: 0)
    assert visit.valid?
  end
  test 'TeleVisit Model Validity: creating an invalid televisit model and checking the error constraint - appointment_id' do
    visit = TeleVisit.create(session_id: 1213123, patient_token: 12312, doctor_token: 2312, status: 0)
    visit.save
    assert_equal visit.errors.full_messages[0], "Appointment can't be blank"
  end
  test 'TeleVisit Model Validity: creating an invalid televisit model and checking the error constraint - session_id' do
    visit = TeleVisit.create(appointment_id: 99999, patient_token: 12312, doctor_token: 2312, status: 0)
    visit.save
    assert_equal visit.errors.full_messages[0], "Session can't be blank"
  end
  test 'TeleVisit Model Validity: creating an invalid televisit model and checking the error constraint - patient_token' do
    visit = TeleVisit.create(appointment_id: 99999, session_id: 1213123, doctor_token: 2312, status: 0)
    visit.save
    assert_equal visit.errors.full_messages[0], "Patient token can't be blank"
  end
  test 'TeleVisit Model Validity: creating an invalid televisit model and checking the error constraint - status' do
    visit = TeleVisit.create(appointment_id: 99999, session_id: 1213123, patient_token: 2312, doctor_token: 0)
    visit.save
    assert_equal visit.errors.full_messages[0], "Status can't be blank"
  end
  test 'TeleVisit Model Validity: creating an invalid televisit model and checking the full error constraint' do
    visit = TeleVisit.create()
    visit.save
    assert_equal visit.errors.full_messages, ["Appointment can't be blank", "Session can't be blank", "Patient token can't be blank", "Doctor token can't be blank", "Status can't be blank"]
  end
end
