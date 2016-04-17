require 'rails_helper'
include VkOauthStubHelper

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  let!(:group) { create :group, user_id: user }
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

  it ".join_group adds given group to users\'s groups" do
    expect{ user.join_group(group) }.to change{ user.groups.count }.from(0).to(1)
    expect(user.groups).to include(group)
  end

  it ".join_group adds user to given group's users" do
    expect{ user.join_group(group) }.to change{ group.users.count }.from(0).to(1)
    expect(group.users).to include(user)
  end

  it ".leave_group removes given group from users\'s groups" do
    user.join_group(group)
    expect{ user.leave_group(group) }.to change{ user.groups.count }.from(1).to(0)
    expect(user.groups.reload).not_to include(group)
    expect(Group.find(group.id)).not_to be nil
  end

  it ".leave_group removes user from given group\'s users" do
    user.join_group(group)
    expect{ user.leave_group(group) }.to change{ group.users.count }.from(1).to(0)
    expect(group.users).not_to include(user)
    expect(User.find(user.id)).not_to be nil
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
#  sign_in_count          :integer          default("0"), not null
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
