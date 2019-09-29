class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :apartment
      t.string :state
      t.string :city
      t.string :zip_code
      t.string :ssn
      t.boolean :archived, default: false
      t.string :phone

      t.timestamps
    end
  end
end
