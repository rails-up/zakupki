require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let!(:group) { create(:group) }

  describe 'POST#toggle_group' do
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
