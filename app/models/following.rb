class Following < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end

# == Schema Information
#
# Table name: followings
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_followings_on_followed_id                  (followed_id)
#  index_followings_on_follower_id                  (follower_id)
#  index_followings_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
