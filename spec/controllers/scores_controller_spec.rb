require 'spec_helper'

describe ScoresController do
  let(:user) { FactoryGirl.create(:user) }
  before { session[:user_id] = user.id }

  describe "add score with ajax" do
    it "should increase score by amount" do
      expect do
        xhr :post, :create, score: { points: 10, rounds: 1 }
      end.to change(Score, :count).by(1)
    end

    it "should be successful" do
      xhr :post, :create, score: { points: 10, rounds: 1 }
      response.should be_success
    end
  end

  describe "add a score of zero" do
    it "should be game over" do
      xhr :post, :create, score: { points: 0, rounds: 1 }
      response.should have_selector('h1', 'Thank you for playing!')
    end
  end
end