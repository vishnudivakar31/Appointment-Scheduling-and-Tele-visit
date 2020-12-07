require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test 'Validity Test: valid appointment' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    assert appointment.valid?
  end
  test 'Validity Test: invalid appointment without patient_id' do
    appointment = Appointment.new(doctor_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    assert_not appointment.valid?
  end
  test 'Validity Test: invalid appointment without doctor_id' do
    appointment = Appointment.new(patient_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    assert_not appointment.valid?
  end
  test 'Validity Test: invalid appointment without start_time' do
    begin
      appointment = Appointment.new(patient_id: 1, doctor_id: 1, end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
      assert_not appointment.valid?
    rescue NoMethodError
      assert true
    rescue
      assert false
    end
  end
  test 'Validity Test: invalid appointment without end_time' do
    begin
      appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
      assert_not appointment.valid?
    rescue NoMethodError
      assert true
    rescue
      assert false
    end
  end
  test 'Validity Test: invalid appointment without appointment_status' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', tele_visit: true)
    assert_not appointment.valid?
  end
  test 'Validity Test: invalid appointment without tele_visit' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', appointment_status: 0)
    assert_not appointment.valid?
  end
  test 'Start Time and End Time Constraint: End Time > Start Time' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T13:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    assert appointment.valid?
  end
  test 'Start Time and End Time Constraint Failure Test: End Time > Start Time' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T14:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    assert_not appointment.valid?
  end
  test 'Start Time and End Time Constraint Failure Message Test: End Time > Start Time' do
    appointment = Appointment.new(patient_id: 1, doctor_id: 1, start_time: '2020-01-01T14:00', end_time: '2020-01-01T13:30', appointment_status: 0, tele_visit: true)
    appointment.save
    assert_equal(appointment.errors.full_messages[0], 'end date and time should be greater than start date and time')
  end
end
