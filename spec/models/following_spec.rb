require 'rails_helper'

RSpec.describe Following, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
