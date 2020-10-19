class CreateCharts < ActiveRecord::Migration[6.0]
  def change
    create_table :charts, id: false do |t|
      t.primary_key :appointment_id
      t.text :file_path

      t.timestamps
    end
  end
end
