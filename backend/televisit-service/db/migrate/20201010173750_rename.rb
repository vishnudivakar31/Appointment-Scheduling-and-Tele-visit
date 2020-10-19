class Rename < ActiveRecord::Migration[6.0]
  def change
    rename_column :tele_visits, :consulation_file_path, :consultation_file_path
  end
end
