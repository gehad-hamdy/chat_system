require 'rails_helper'

RSpec.describe "toys/index", type: :view do
  before(:each) do
    assign(:toys, [
      Toy.create!(
        name: "MyText",
        color: "MyText"
      ),
      Toy.create!(
        name: "MyText",
        color: "MyText"
      )
    ])
  end

  it "renders a list of toys" do
    render
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
