require 'rails_helper'
include VkOauthStubHelper

RSpec.describe User, type: :model do
  it { should have_many(:purchases) }

  let!(:user) { create :user }
  let!(:group) { create :group, owner: user }
  let!(:purchase) { create :purchase, owner: user }
  let!(:other_user) { create :user }
  let!(:vk_user) { create :user_from_vkontakte }

  it "cannot follow itself" do
    user.follow(user)
    expect(user.followers).not_to include user
  end

  context "when performs following" do
    before(:each) { user.follow(other_user) }

    it "can follow other user" do
      expect(other_user.followers).to include user
    end

    it "can unfollow user" do
      user.unfollow(other_user)
      expect(other_user.followers).not_to include user
    end

    it ".follow creates relationships between two users" do
      expect(user.active_relationships.find_by(followed_id: other_user.id)).not_to be nil
      expect(other_user.passive_relationships.find_by(follower_id: user.id)).not_to be nil
    end

    it ".following shows if user has followed other user or not" do
      expect(user.following?(other_user)).to be true
    end

    it ".unfollow destroys relationships between two users" do
      user.unfollow(other_user)
      expect(user.active_relationships.find_by(followed_id: other_user.id)).to be nil
      expect(other_user.passive_relationships.find_by(follower_id: user.id)).to be nil
    end
  end

  it "can be created with email=nil" do
    user_without_email = create(:user, email: nil)
    expect(user_without_email).to be_instance_of User
  end

  context "when created from omniauth" do

    let!(:existing_auth) { vk_json }
    let!(:new_auth) { vk_new_json }

    it "returns user, when it exists" do
      existing_user = User.from_omniauth(existing_auth)
      expect(existing_user).to be_instance_of User
    end

    it "returns new user, when it does not exist" do
      new_user = User.from_omniauth(new_auth)
      expect(new_user).to be_instance_of User
    end
  end

  it ".gravatar returns avatar url when user has linked email" do
    expect(user.gravatar).to be_url
  end

  it ".gravatar returns avatar url when user has not linked email " do
    expect(vk_user.gravatar).to be_url
  end

  describe '.toggle_group' do
    it 'joins when user is not in a group' do
      expect { user.toggle_group(group) }.to change(user.groups, :count).by(1)
    end

    it 'leaves when user joined to group' do
      user.groups << group
      expect { user.toggle_group(group) }.to change(user.groups, :count).by(-1)
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  role_id                :integer
#  phone                  :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
