require 'rails_helper'

  describe Group do
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:purchases) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(8) }

    pending 'after approve must belong to creator'

    describe '.all_with_non_exist' do
      let!(:groups) { create_list(:group, 2, enabled: true) }
      before { groups }

      it 'add non exist group to all' do
        expect(Group.all_with_non_exist).to include([I18n.t('group.non_exist'), 'null'])
      end

      it 'return include all enabled groups' do
        expect(Group.all_with_non_exist.count).to eq 3
      end
    end
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
#  enabled     :boolean          default(FALSE)
#  user_id     :integer
#
# Indexes
#
#  index_groups_on_user_id  (user_id)
#
