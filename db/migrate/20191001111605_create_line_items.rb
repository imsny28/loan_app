class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.string :name
			t.boolean :archived, default: false
			t.decimal :amount, precision: 30, scale: 5, default: "0.0"
			t.text :custom_field
			
			t.string :status, default: 'cart', null: false
			t.string :financial_status, default: 'pending', null: false

			t.integer :collateral_id
			t.integer :loan_id

      t.timestamps
    end
  end
end
