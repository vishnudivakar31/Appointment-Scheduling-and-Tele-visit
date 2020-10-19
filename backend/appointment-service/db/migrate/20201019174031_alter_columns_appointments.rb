class AlterColumnsAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :date
    change_column :appointments, :appointment_status, :integer
    remove_column :charts, :appointment_id
    add_column :charts, :id, :primary_key
    add_column :charts, :appointment_id, :integer
  end
end
