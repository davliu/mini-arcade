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

  describe "add a non-zero score" do
    render_views
    it "should not be game over" do
      xhr :post, :create, score: { points: 10, rounds: 1 }
      response.body.should_not include("window.location = '#{game_over_path}'")
    end
  end

  describe "add a score of zero" do
    render_views
    it "should be game over" do
      xhr :post, :create, score: { points: 0, rounds: 1 }
      response.body.should include("window.location = '#{game_over_path}'")
    end

    describe "adding points to user total" do
      it "should increase player score" do
        expect do
          xhr :post, :create, score: { points: 30, rounds: 1 }
          xhr :post, :create, score: { points: 50, rounds: 1 }
          xhr :post, :create, score: { points: 0, rounds: 1 }
        end.to change{ User.find_by_id(session[:user_id]).total_score }.by(80)
      end
    end
  end
end