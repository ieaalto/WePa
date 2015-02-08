require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved if it has name and style" do
    beer = Beer.create name:"Kalja", style:"Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "without a name is not saved" do
    beer = Beer.create style:"Lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "without a style is not saved" do
    beer = Beer.create name:"Lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
