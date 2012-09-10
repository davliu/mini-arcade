# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  total_score :integer
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: 'David') }

  subject { @user }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "when name is blank" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
end
