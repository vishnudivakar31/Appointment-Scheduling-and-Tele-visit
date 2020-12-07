require 'test_helper'

class BillingCodeTest < ActiveSupport::TestCase
  test 'Billing Codes Validity Test: valid billing code' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    appointment.save
    billing_code = BillingCode.new(code: 'BA1', appointment_id: appointment.id)
    assert billing_code.valid?
    appointment.destroy
  end
  test "Billing Codes Validity Test: appointment id can't be blank" do
    billing_code = BillingCode.new(code: 'BA1')
    billing_code.valid?
    assert_equal(billing_code.errors.full_messages[0], "Appointment can't be blank")
  end
  test "Billing Codes Validity Test: appointment should exist" do
    billing_code = BillingCode.new(code: 'BA1')
    billing_code.valid?
    assert_equal(billing_code.errors.full_messages[1], "Appointment must exist")
  end
  test 'Billing Codes Validity Test: missing billing code' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    appointment.save
    billing_code = BillingCode.new(appointment_id: appointment.id)
    billing_code.valid?
    assert_equal(billing_code.errors.full_messages, ["Code can't be blank"])
    appointment.destroy
  end
  test 'Billing Codes Relation Test: Get appointment corresponding to billing code' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    appointment.save
    billing_code = BillingCode.new(code: 'BA1', appointment_id: appointment.id)
    billing_code.save
    assert_not_nil billing_code.appointment
    billing_code.destroy
    appointment.destroy
  end
end
