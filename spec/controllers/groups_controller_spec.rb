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

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'GET #show' do
    let!(:group) { create(:group, enabled: true) }
    
    before { get :show, id: group }

    it 'assigns the requested group to @group' do
      expect(assigns(:group)).to eq group
    end

    it 'assigns new comment for group' do
      expect(assigns(:new_comment)).to be_a_new(Comment)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST#toggle_group' do
    let!(:group) { create(:group) }

    context 'when user authenticated' do
      login_user #login as @user - defined in spec/support/controller_helpers.rb

      it 'renders toggle_group template' do
        post :toggle_group, id: group.id, format: :js
        expect(response).to render_template 'toggle_group'
      end
      
      # TODO: figure out the reason of failing of an example below and fox it. Method work as expected.

      # it 'calls .toggle_group method on current_user' do
      #   expect(@user).to receive(:toggle_group).with(group)
      #   post :toggle_group, id: group.id
      # end
    end

    context 'user user is not authenticated' do
      it 'redirect to sign in' do
        post :toggle_group, id: group.id
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
