class CreateChatMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_messages do |t|
      t.belongs_to :application_chat
      t.integer :identifier_number, null: false
      t.text :message
      t.timestamps
    end
    add_index :chat_messages, :identifier_number
  end

  def down
    drop_table :chat_messages
  end
end
