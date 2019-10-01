class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :name
      t.integer :customer_id
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
