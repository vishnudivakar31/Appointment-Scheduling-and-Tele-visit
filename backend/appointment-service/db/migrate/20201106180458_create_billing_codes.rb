class CreateBillingCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :billing_codes do |t|
      t.text :code
      t.integer :appointment_id

      t.timestamps
    end
  end
end
