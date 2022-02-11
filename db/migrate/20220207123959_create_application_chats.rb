class CreateApplicationChats < ActiveRecord::Migration[5.2]
  def change
    create_table :application_chats do |t|
      t.belongs_to :application, optional: false
      t.integer :identifier_number, default: 0
      t.string  :name, null: false
      t.timestamps
    end
  end

  def down
    drop_table :application_chats
  end
end
