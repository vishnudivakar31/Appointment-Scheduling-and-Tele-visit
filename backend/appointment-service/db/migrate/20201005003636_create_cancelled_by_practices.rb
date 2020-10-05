class CreateCancelledByPractices < ActiveRecord::Migration[6.0]
  def change
    create_table :cancelled_by_practices, id: false do |t|
      t.primary_key :appointment_id
      t.string :cancel_reason
      t.integer :patient_id

      t.timestamps
    end
  end
end
