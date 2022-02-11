require 'rails_helper'

RSpec.describe "toys/show", type: :view do
  before(:each) do
    @toy = assign(:toy, Toy.create!(
      name: "MyText",
      color: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
