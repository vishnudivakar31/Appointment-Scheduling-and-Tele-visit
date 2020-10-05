class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments, id: false do |t|
      t.primary_key :appointment_id
      t.integer :patient_id
      t.date :date
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :practice_id
      t.integer :doctor_id
      t.string :appointment_status
      t.string :chart_file_path
      t.string :consultation_summary_file_path

      t.timestamps
    end
  end
end
