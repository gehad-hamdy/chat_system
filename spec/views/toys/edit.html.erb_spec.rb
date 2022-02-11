require 'rails_helper'

RSpec.describe "toys/edit", type: :view do
  before(:each) do
    @toy = assign(:toy, Toy.create!(
      name: "MyText",
      color: "MyText"
    ))
  end

  it "renders the edit toy form" do
    render

    assert_select "form[action=?][method=?]", toy_path(@toy), "post" do

      assert_select "textarea[name=?]", "toy[name]"

      assert_select "textarea[name=?]", "toy[color]"
    end
  end
end
