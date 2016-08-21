require 'rails_helper'

RSpec.describe Order, type: :model do
end

# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  status      :string
#  purchase_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
