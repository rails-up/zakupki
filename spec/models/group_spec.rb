require 'rails_helper'

  describe Group do
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:purchases) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(8) }

    pending 'after approve must belong to creator' 
  end

# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  enabled     :boolean          default("false")
#  city_id     :integer
#  user_id     :integer
#
# Indexes
#
#  index_groups_on_city_id  (city_id)
#  index_groups_on_user_id  (user_id)
#
