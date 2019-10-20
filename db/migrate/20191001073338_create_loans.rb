class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.decimal :total_amount, precision: 30, scale: 5, default: "0.0"
      t.string :currency, limit: 3, default: "USD"
      t.string :status
			t.string :financial_status
      t.datetime :payoff
			t.boolean :archived, default: false
			t.integer :customer_id
			t.string :original_id

			# NOTE: Think later
			# t.string :collateral_name
			# t.string :collateral_type
			# t.string :properties
			# t.string :status, default: 'cart', null: false
			# t.string :financial_status, default: 'pending', null: false

			#t.string :cancel_reason
			#t.datetime :cancelled_at
			#t.string :tag
			#t.string :note
			#t.bigint :credit_card_id
			#t.string :email

      t.timestamps
    end
  end
end
