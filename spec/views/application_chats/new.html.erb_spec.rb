require 'rails_helper'

RSpec.describe "application_chats/new", type: :view do
  before(:each) do
    assign(:application_chat, ApplicationChat.new())
  end

  it "renders new application_chat form" do
    render

    assert_select "form[action=?][method=?]", application_chats_path, "post" do
    end
  end
end
