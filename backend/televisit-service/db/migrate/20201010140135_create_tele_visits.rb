class CreateTeleVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :tele_visits, id: false do |t|
      t.primary_key :appointment_id
      t.string :session_id
      t.string :patient_token
      t.string :doctor_token
      t.timestamp :started_at
      t.timestamp :ended_at
      t.integer :status

      t.timestamps
    end
  end
end
