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

class User < ActiveRecord::Base
  attr_accessible :name, :total_score
  validates :name, presence: true, length: { maximum: 50 }
  has_many :scores, dependent: :destroy
end
