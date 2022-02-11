class ApplicationChat < ApplicationRecord

  belongs_to :application
  has_many :chat_messages

  def as_json(options = {})
    {
      application_token: self.application.identifier_token,
      name: name,
      number: identifier_number,
      messages_count: messages_count
    }
  end
end
