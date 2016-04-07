require 'rails_helper'

RSpec.describe Comment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
