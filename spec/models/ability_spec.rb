require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  shared_examples 'guest abilities' do
    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }
  end

  shared_examples 'user abilities' do
    it { should be_able_to :create, Order }

    it { should be_able_to :manage, create(:order, user: user), user: user }
    it { should_not be_able_to :manage, create(:order, user: other), user: user }

    it { should be_able_to :edit, user, user: user }
    it { should_not be_able_to :edit, other, user: user }

    it { should be_able_to :update, user, user: user }
    it { should_not be_able_to :update, other, user: user }

    it { should be_able_to :update, create(:purchase, owner: user), user: user }
    it { should_not be_able_to :update, create(:purchase, owner: other), user: user }

    it { should be_able_to :destroy, create(:purchase, owner: user), user: user }
    it { should_not be_able_to :destroy, create(:purchase, owner: other), user: user }

    it { should be_able_to :manage, create(:comment, user: user), user: user }
    it { should_not be_able_to :manage, create(:comment, user: other), user: user }

    it { should be_able_to :toggle_group, Group }
  end

  describe 'guest' do
    let(:user) { nil }

    it_behaves_like 'guest abilities'
  end

  describe 'user' do
    let(:user) { create :user }
    let(:other) { create :user }

    it_behaves_like 'guest abilities'
    it_behaves_like 'user abilities'
  end

  describe 'organizer' do
    let(:user) { create :user, :organizer }
    let(:other) { create :user }

    it_behaves_like 'guest abilities'
    it_behaves_like 'user abilities'

    it { should be_able_to :manage, create(:purchase, owner: user), user: user }
    it { should_not be_able_to :manage, create(:purchase, owner: other), user: user }

    it { should be_able_to :change_state, create(:purchase, owner: user), user: user }
    it { should_not be_able_to :change_state, create(:purchase, owner: other), user: user }
  end

  describe 'moderator' do
    let(:user) { create :user, :organizer }
    let(:other) { create :user }

    it_behaves_like 'guest abilities'

    it { should_not be_able_to :manage, [Group, Purchase, Order] }
    it { should_not be_able_to [:edit, :update], User }
  end

  describe 'admin' do
    let(:user) { create :user, :admin }
    it { should be_able_to :manage, :all }
  end

  describe 'banned' do
    let(:user) { create :user, :banned }
    it { should_not be_able_to :manage, :all }
  end
end
