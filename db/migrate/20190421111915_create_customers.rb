class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :apartment
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :security_number

      t.timestamps
    end
  end
end
