require 'spec_helper'

describe "GamePlayPages" do
  subject { page }

  describe "new user playing" do
    let(:user) { FactoryGirl.create(:user) }

    it "should start out with no scores" do
      user.scores.count.should == 0
    end
  end

  describe "no user session" do
    before { visit game_over_path }
    describe "redirect to new game" do
      before { visit spinning_game_path }
      it { should have_selector('h1', text: "Mini Arcade") }
      it { should have_selector 'div.alert.alert-error', text:  'Provide' }

      describe "after visiting another page" do
        before { visit root_path }
        it { should_not have_selector 'div.alert.alert-error', text:  'Provide' }
      end
    end
  end

  describe "high score table" do
    before { visit game_over_path }
    it { should have_selector('table.high-scores tr', maximum: 10) }
  end

  describe "play new game" do
    before {
      visit game_over_path
      click_link "Play Again"
    }
    it { should have_selector('h1', text: "Mini Arcade") }
  end
end