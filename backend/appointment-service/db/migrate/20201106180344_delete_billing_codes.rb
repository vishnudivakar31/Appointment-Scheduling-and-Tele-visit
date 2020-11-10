class DeleteBillingCodes < ActiveRecord::Migration[6.0]
  def change
    drop_table :billing_codes
  end
end
