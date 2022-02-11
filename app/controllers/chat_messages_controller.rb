require 'assets/rabbitmq_queue'

class ChatMessagesController < ApplicationController
  # before_action :set_chat_message, only: [:show, :edit, :update, :destroy]
  rescue_from ActionController::ParameterMissing, with: :handle_missing_parameter

  # GET /chat_messages
  def index
    verify_application_chat_tokens or return
    chat_messages = @chat.chat_messages
    render status: :ok, json: { data: chat_messages, message: "data fetched successfully" }
  end

  # GET /chat_messages/1
  def show
    verify_application_chat_tokens or return
    verify_message_number or return
    render status: :ok, json: { data: @chat_message, message: "data fetched successfully" }
  end

  # GET /chat_messages/new
  def new
    @chat_message = ChatMessage.new
  end

  # GET /chat_messages/1/edit
  def edit
  end

  # POST /chat_messages
  def create
    verify_application_chat_tokens or return

    chat_messages = @chat.chat_messages
    RabbitmqQueue.enqueue({type: "create", message: message_body(chat_messages)})

    render status: :created, json: {data: message_body(chat_messages), message: "Message created successfully"}
  end

  # PATCH/PUT /chat_messages/1
  def update
    verify_application_chat_tokens or return
    verify_message_number or return

    @chat_message.assign_attributes(message: chat_message_params[:body])
    RabbitmqQueue.enqueue({type: "edit", message: @chat_message})

    render status: :no_content
  end

  def search
    verify_application_chat_tokens or return
    render status: :ok, json: {data: get_messages_by_text,  message: "Message Search Result fetched successfully"}
  end

  # DELETE /chat_messages/1
  def destroy
    # @chat_message.destroy
    # redirect_to chat_messages_url, notice: 'Chat message was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat_message
    @chat_message = ChatMessage.find(params[:id])
  end

  def message_body(chat_messages)
    chat_messages.new(identifier_number: @chat.messages_count + 1, message: chat_message_params[:body])
  end

  # Only allow a trusted parameter "white list" through.
  def chat_message_params
    params.require('chat_message').permit(:body)
  end

  def get_messages_by_text
    @chat.chat_messages.search(params[:body] || '').results
  end

  def verify_application_chat_tokens
    @application = Application.find_by_identifier_token(params[:token])
    handle_error("application token") and return false unless @application
    @chat = @application.application_chats.find_by(:identifier_number => params[:number])
    handle_error("chat number") and return false unless @chat

    true
  end

  def verify_message_number
    @chat_message = @chat.chat_messages.find_by(:identifier_number => params[:number])
    handle_error("message number") and return false unless @chat_message

    true
  end

  def handle_error(invalid_parameter)
    render status: :bad_request, json: { errors: "Invalid #{invalid_parameter}" }
  end

  def handle_missing_parameter(exception)
    render status: :bad_request, json: { errors: exception.message }
  end
end
