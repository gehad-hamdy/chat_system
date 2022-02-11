require 'rails_helper'

RSpec.describe "chat_messages/index", type: :view do
  before(:each) do
    assign(:chat_messages, [
      ChatMessage.create!(),
      ChatMessage.create!()
    ])
  end

  it "renders a list of chat_messages" do
    render
  end
end
