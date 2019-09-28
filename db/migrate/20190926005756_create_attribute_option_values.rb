class CreateAttributeOptionValues < ActiveRecord::Migration[5.2]
  def change
    create_table :attribute_option_values do |t|
      t.string :name
      t.string :display_name
      t.integer :attribute_option_id
      t.boolean :archived, default: false
      
      t.timestamps
    end
  end
end
