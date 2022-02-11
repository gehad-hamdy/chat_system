require 'rails_helper'

RSpec.describe "application_chats/index", type: :view do
  before(:each) do
    assign(:application_chats, [
      ApplicationChat.create!(),
      ApplicationChat.create!()
    ])
  end

  it "renders a list of application_chats" do
    render
  end
end
