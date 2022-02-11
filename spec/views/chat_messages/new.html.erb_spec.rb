require 'rails_helper'

RSpec.describe "chat_messages/new", type: :view do
  before(:each) do
    assign(:chat_message, ChatMessage.new())
  end

  it "renders new chat_message form" do
    render

    assert_select "form[action=?][method=?]", chat_messages_path, "post" do
    end
  end
end
