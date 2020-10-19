class RenameForeignKeyChart < ActiveRecord::Migration[6.0]
  def change
    rename_column :charts, :televisit_id, :tele_visit_id
  end
end
