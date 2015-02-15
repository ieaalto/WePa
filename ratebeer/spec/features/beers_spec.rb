require 'rails_helper'

describe 'Beer' do
  it "can be added with valid name" do
    visit new_beer_path
    fill_in('beer_name', with:"kalja")
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  describe 'posted with invalid name' do
    before :each do
      visit new_beer_path
    end

    it "won´t be added to database" do
      click_button "Create Beer"
      expect(Beer.count).to eq(0)
    end

    it "redirects back and displays the error message" do
      click_button "Create Beer"
      expect(current_path).to eq(new_beer_path)
      expect(page).to have_content "Name can't be blank"
    end
  end
end