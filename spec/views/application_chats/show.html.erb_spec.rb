require 'rails_helper'

RSpec.describe "application_chats/show", type: :view do
  before(:each) do
    @application_chat = assign(:application_chat, ApplicationChat.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
