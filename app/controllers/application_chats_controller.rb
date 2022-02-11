require 'assets/rabbitmq_queue'

class ApplicationChatsController < ApplicationController
   before_action :set_application_chat, only: [:show, :edit, :update, :destroy]

  # GET /application_chats
  def index
    verify_application_token or return
    application_chats = @application.application_chats
    render status: :ok, json: {chats: application_chats, message: "fetch data successfully"}
  end

  # GET /application_chats/1
  def show
    verify_application_token or return
    verify_chat_number or return

    render status: :ok, json: {chat: @application_chat, message: "fetch data successfully"}
  end

  # GET /application_chats/new
  def new
    @application_chat = ApplicationChat.new
  end

  # GET /application_chats/1/edit
  def edit
  end

  # POST /application_chats
  def create
    verify_application_token or return
    application_chats = @application.application_chats

    RabbitmqQueue.enqueue({type: "create", chat: chat_message(application_chats)})

    render status: :created, json: {chat: chat_message(application_chats)}
  end

  # PATCH/PUT /application_chats/1
  def update
    verify_application_token or return

    @application.assign_attributes(name: application_chat_params[:name])
    RabbitmqQueue.enqueue({type: "edit", application: @application})

    render status: :no_content
  end

  # DELETE /application_chats/1
  def destroy
    # @application_chat.destroy
    # redirect_to application_chats_url, notice: 'Application chat was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application_chat
      @application_chat = ApplicationChat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def application_chat_params
      params.require(:application_chat).permit(:name)
    end

    def verify_application_token
      @application = Application.find_by_identifier_token(params[:token])
      handle_error("application token") and return false unless @application

      true
    end

  # Use callbacks to share common setup or constraints between actions.
    def verify_chat_number
      @application_chat = @application.application_chats.find_by(:id => params[:id])
      handle_error("chat number") and return false unless @application_chat

      true
    end

    def handle_error(invalid_parameter)
      render status: :bad_request, json: {errors: "Invalid #{invalid_parameter}"}
    end

    def chat_message(application_chats)
      application_chats.new(identifier_number: @application.chat_count + 1, name: application_chat_params[:name], application_id: application_chat_params[:application_id])
    end
end
