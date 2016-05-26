require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET #index' do
    context 'when user is logged in' do
      it 'should let a user see profile' do
        login_with create :user
        get :show
        expect(response).to render_template :show
      end
    end

    context 'when user is logged out' do
      before do
        login_with nil
        get :show
      end
      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'GET #edit' do
    login_user

    it 'returns http success' do
      login_with create :user
      get :edit
      expect(response).to have_http_status(:success)
    end

    describe 'Update should change current user info' do
      let(:attr) do
        { username: 'New username', phone: '999-999-999' }
      end

      before(:each) do
        post :update, user: attr
      end

      it { expect(response).to redirect_to(user_profile_url) }
      it { expect(controller.current_user.username).to eql attr[:username] }
      it { expect(controller.current_user.phone).to eql attr[:phone] }
    end
  end
end
