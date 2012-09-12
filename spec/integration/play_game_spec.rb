require 'spec_helper'

describe "play new game" do
  it "should go through a standard play through" do
    visit root_path
    fill_in 'user_name', with: "david"
    click_button 'Go'
    page.should have_selector('h1', text: "Spinny, the Spinning Game")
    User.stub(:find_by_id => User.last)
    expect do
      xhr :post, url_for(:controller => 'scores', :action => 'create'), score: { points: 50, rounds: 1 }
      xhr :post, url_for(:controller => 'scores', :action => 'create'), score: { points: 30, rounds: 1 }
      xhr :post, url_for(:controller => 'scores', :action => 'create'), score: { points: 10, rounds: 1 }
      xhr :post, url_for(:controller => 'scores', :action => 'create'), score: { points: 0, rounds: 1 }
    end.to change{ User.find_by_id(User.last.id).total_score }.by(90)
    response.body.should include("window.location = '#{game_over_path}'")
  end
end

describe "new game" do
  it "should redirect to new user page" do
    visit game_over_path
    click_link "Play Again"
    page.should have_selector('h1', text: "Mini Arcade")
  end
end