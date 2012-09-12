require 'spec_helper'

describe "new user page" do
  it "should display new user page" do
    visit root_path
    fill_in 'user_name', with: "david"
    click_button 'Go'
    page.should have_selector('h1', text: "Spinny, the Spinning Game")
  end
end

describe "new game" do
  it "should redirect to new user page" do
    visit game_over_path
    click_link "Play Again"
    page.should have_selector('h1', text: "Mini Arcade")
  end
end