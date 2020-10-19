class RemoveConsultationFilePath < ActiveRecord::Migration[6.0]
  def change
    remove_column :tele_visits, :consultation_file_path
  end
end
