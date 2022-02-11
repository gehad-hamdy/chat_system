require 'rails_helper'

RSpec.describe "toys/new", type: :view do
  before(:each) do
    assign(:toy, Toy.new(
      name: "MyText",
      color: "MyText"
    ))
  end

  it "renders new toy form" do
    render

    assert_select "form[action=?][method=?]", toys_path, "post" do

      assert_select "textarea[name=?]", "toy[name]"

      assert_select "textarea[name=?]", "toy[color]"
    end
  end
end
