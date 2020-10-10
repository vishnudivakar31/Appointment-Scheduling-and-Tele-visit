class CreateCharts < ActiveRecord::Migration[6.0]
  def change
    create_table :charts do |t|
      t.string :file_path
      t.integer :televisit_id

      t.timestamps
    end
  end
end
