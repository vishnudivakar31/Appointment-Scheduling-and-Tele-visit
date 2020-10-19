class RemoveChartsTelevisit < ActiveRecord::Migration[6.0]
  def change
    remove_column :tele_visits, :charts
  end
end
