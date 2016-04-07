class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :purchase
end

# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  content     :text
#  purchase_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
