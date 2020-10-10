class AddChartConsulationForTelevisit < ActiveRecord::Migration[6.0]
  def change
    add_column :tele_visits, :charts, :integer
    add_column :tele_visits, :consulation_file_path, :string
  end
end
