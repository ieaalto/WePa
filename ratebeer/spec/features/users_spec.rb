require 'rails_helper'

describe "User" do
  before :each do
    @user = FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Invalid password or username'
    end

    it "has his/her favorite style and brewery displayed" do
      visit user_path(@user)
      expect(page).to have_content 'favorite style'
      expect(page).to have_content 'favorite brewery'
    end

    it "has his/her ratings displayed" do
      create_beers_with_ratings(1,2,3,@user)
      visit_user_path(@user)
      Rating.all.each do |rating|
        if rating.user == @user
          expect(page).to have_content rating.to_s
        end
      end
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end