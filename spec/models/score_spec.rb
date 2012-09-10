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

  describe "accessible attributes" do
    let(:user) { FactoryGirl.create(:user) }
    it "should not allow access to user_id" do
      expect do
        Score.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
