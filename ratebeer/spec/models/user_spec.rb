require 'rails_helper'

RSpec.describe User, type: :model do
  it "without a password is not saved" do
    user = User.new username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "with a valid password is saved" do
    user = FactoryGirl.create(:user)

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

  it "with a too short password is not saved" do
    user = User.create username:"Pekka", password:"S1", password_confirmation:"S1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "with a bad password is not saved" do
    user = User.create username:"Pekka", password:"secret", password_confirmation:"secret"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user)}

    it 'has method determinining one' do
      expect(user).to respond_to(:favorite_beer)
    end

    it 'without rating doesn´t have one' do
      expect(user.favorite_beer).to eq(nil)
    end

    it 'is the only rated if only one rating' do
      beer = create_beer_with_rating

      expect(user.favorite_beer).to eq(beer)
    end

    it 'is the one with highest rating if several rated' do
      create_beers_with_ratings(5,10,15, user)
      beer = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(beer)
    end

  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user)}

    it 'method exists' do
      expect(user).to respond_to(:favorite_style)
    end

    it 'is the one with highest rated beers if several rated' do
      create_beers_with_ratings(5,10,15, user)
      beer = create_beer_with_rating(50, user)
      beer.style = "IPA"
      expect(user.favorite_style).to eq("IPA")
    end
  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user)}

    it 'method exists' do
      expect(user).to respond_to(:favorite_brewery)
    end

    it 'is the one with highest rated beers if several rated' do
      create_beers_with_ratings(5,10,15, user)
      beer = create_beer_with_rating(50, user)
      beer.brewery = FactoryGirl.create(:brewery)
      expect(user.favorite_brewery).to eq(beer.brewery)
    end
  end
end

