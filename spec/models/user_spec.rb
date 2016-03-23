require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  let!(:other_user) { create :user }

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
end
