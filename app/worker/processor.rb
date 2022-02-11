require 'bunny'
require 'sneakers'
require 'application'

class Processor
  include Sneakers::Worker
  from_queue :jobs

  def work(message_body)
    message_body_json = JSON.parse(message_body)
    ## consume application chat data
      if message_body_json.key? "chat"
        @application = Application.find_by_identifier_token(message_body_json["chat"]["application_token"])
          handle_chat_request(@application, message_body_json)
      end

    ## consume chat message data
    if message_body_json.key? "message"
      application = Application.find_by_identifier_token(message_body_json["message"]["application_token"])
      handle_message_request(application, message_body_json)
    end
    ack!
  end

  def create_chat( application, message_body)
    application.application_chats.create(identifier_number: message_body["chat"]["number"], name: message_body["chat"]["name"], application_id: message_body["chat"]["application_id"], messages_count: 0)
    update_application_chat_count(application)
  end

  def update_chat(application, message_body)
    chat = application.application_chats.find_by(identifier_number: message_body["chat"]["number"])
    chat.update(message: message_body["application"]["name"])
  end

  def handle_chat_request(application, message_body_json)
    if message_body_json["type"] == "create"
      create_chat(application, message_body_json)
    else
      update_chat(application, message_body_json)
    end
  end

  def update_message(chat, message_body)
    chat = chat.chat_messages.find_by(identifier_number: message_body["message"]["chat_number"])
    chat.update(message: message_body["message"]["message"])
  end

  def create_message(chat, message_body)
    chat.chat_messages.create(application_chat_id: chat.id, identifier_number: message_body["message"]["number"], message: message_body["message"]["message"])

    update_chat_message_count(chat)
  end

  def handle_message_request(application, message_body)
    @chat = application.application_chats.find_by(identifier_number: message_body["message"]["chat_number"])

    if message_body["type"] == "edit"
      update_message(@chat, message_body)
    else
      create_message(@chat, message_body)
    end
  end

  private
  def update_application_chat_count(application)
    application.chat_count += 1
    application.save
  end

  def update_chat_message_count(chat)
    chat.messages_count += 1
    chat.save
  end
end