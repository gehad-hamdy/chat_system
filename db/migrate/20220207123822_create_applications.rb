class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.string :identifier_token, null: false
      t.timestamps
    end
    add_index :applications, :identifier_token
  end

  def down
    drop_table :applications
  end
end
