class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :rountine_number
      t.integer :account_number
      t.integer :customer_id

      t.timestamps
    end
  end
end
