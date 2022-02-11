require 'rails_helper'

RSpec.describe "chat_messages/edit", type: :view do
  before(:each) do
    @chat_message = assign(:chat_message, ChatMessage.create!())
  end

  it "renders the edit chat_message form" do
    render

    assert_select "form[action=?][method=?]", chat_message_path(@chat_message), "post" do
    end
  end
end
