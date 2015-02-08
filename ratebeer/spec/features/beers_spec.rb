require 'rails_helper'

describe 'Beer' do
  it "can be added with valid name" do
    visit new_beer_path
    fill_in('beer[name]', with:"kalja")
    select('Lager', from:'beer[style]')
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  describe 'posted with invalid name' do
    before :each do
      visit new_beer_path
      select('Lager', from:'beer[style]')
    end

    it "won´t be added to database" do
      expect{
        click_button "Create Beer"
      }.not_to change{Beer.count}.from(0).to(1)
    end

    it "redirects back and displays the error message" do
      click_button "Create Beer"
      expect(current_path).to eq(new_beer_path)
      expect(page).to have_content "Name can't be blank"
    end
  end
end