class AlterAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :practice_id
    remove_column :appointments, :chart_file_path
    remove_column :appointments, :consultation_summary_file_path
    rename_column :cancelled_by_practices, :patient_id, :doctor_id
  end
end
