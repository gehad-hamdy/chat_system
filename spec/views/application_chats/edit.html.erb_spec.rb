require 'rails_helper'

RSpec.describe "application_chats/edit", type: :view do
  before(:each) do
    @application_chat = assign(:application_chat, ApplicationChat.create!())
  end

  it "renders the edit application_chat form" do
    render

    assert_select "form[action=?][method=?]", application_chat_path(@application_chat), "post" do
    end
  end
end
