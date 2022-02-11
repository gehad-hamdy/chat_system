require 'elasticsearch/model'

class ChatMessage < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :application_chat

  def as_json(options = {})
    {
      application_token: self.application_chat.application.identifier_token,
      chat_number: self.application_chat.identifier_number,
      number: identifier_number,
      message: message
    }
  end

  def as_indexed_json(options = nil)
    self.as_json( only: [ :message ] )
  end

  # after_commit on: [:create] do
  #   __elasticsearch__.index_document
  # end
  #
  # after_commit on: [:update] do
  #   __elasticsearch__.index_document
  # end
  #
  # after_commit on: [:destroy] do
  #   __elasticsearch__.delete_document
  # end

end

# ChatMessage.__elasticsearch__.create_index! index: :message
ChatMessage.__elasticsearch__.create_index! force: true

ChatMessage.import