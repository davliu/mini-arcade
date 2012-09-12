require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "play page" do
    before { visit play_path }
    it { should have_selector('h1', text: 'Mini Arcade') }
    it { should have_selector('title', text: 'Mini Arcade') }
  end

  describe "enter name" do
    before { visit play_path }
    let(:submit) { "Go" }

    describe "invalid name" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
        it { should have_selector('h1', text: "Mini Arcade") }
        it { should have_content('error') }
      end
    end

    describe "valid name" do
      before do
        fill_in "user_name", with: "Example User"
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after user is saved" do
        before { click_button submit }
        let(:user) { User.last }
        it { should have_selector('h1', text: "Spinny, the Spinning Game") }
        it { should have_selector('h2', text: user.name)}
      end
    end
  end
end
