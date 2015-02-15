require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved if it has name and style" do
    style = Style.create(name:"style")
    beer = Beer.create(name:"name", style:style)

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "without a name is not saved" do
    beer = Beer.create(style:FactoryGirl.create(:style))
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "without a style is not saved" do
    beer = Beer.create name:"Lager"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
