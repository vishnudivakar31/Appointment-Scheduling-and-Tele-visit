class AddIsTeleVisitToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :tele_visit, :boolean
  end
end
