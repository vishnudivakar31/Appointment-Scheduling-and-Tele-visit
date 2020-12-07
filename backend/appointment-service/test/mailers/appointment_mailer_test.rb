require 'test_helper'

class AppointmentMailerTest < ActionMailer::TestCase
  def setup
    @appointment = Appointment.new(patient_id: 1, 
        doctor_id: 1, 
        start_time: '2020-01-01T13:00', 
        end_time: '2020-01-01T13:30', 
        appointment_status: 0, 
        tele_visit: true)
    @appointment.save
    @email = 'test@gmail.com'
  end
  def teardown
    @appointment.destroy
  end
  test 'Notification: Basic email composition' do
      email_obj = AppointmentMailer.with(appointment: @appointment, email: @email).new_appointment_email.deliver_now
      assert_equal email_obj.to, [@email]
      assert_equal email_obj.from, ['noreply.appointmentservice@gmail.com']
      assert_equal email_obj.subject, 'Scheduled a new appointment with Appointment and TeleVisit Service'
  end
end
