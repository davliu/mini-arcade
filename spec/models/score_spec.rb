# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  points     :integer
#  rounds     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'spec_helper'

describe Score do
  describe "board" do
    describe "it should have 7 rows" do
      subject { Score.get_spinning_board.length }
      it { should == 7}
    end

    describe "it should have 7 columns" do
      subject { Score.get_spinning_board[0].length }
      it { should == 7}
    end
  end

  describe 'score to image function' do
    subject { Score.score_to_image.length }
    it { should == 4 }
  end

  describe "add score with ajax" do
    let(:user) { FactoryGirl.create(:user) }
    it "should increase score by amount" do
      expect do
        xhr :post, :create, score: { user_id: user.id, points: 10, rounds: 1 }
      end.to change(Score, :count).by(1)
    end

    it "should be successful" do
      xhr :post, :create, score: { user_id: user.id, points: 10, rounds: 1 }
      response.should be_success
    end
  end
end
