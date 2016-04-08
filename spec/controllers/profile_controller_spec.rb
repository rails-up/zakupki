require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

  describe 'GET #index' do
    context 'when user is logged in' do
      it "should let a user see profile" do
        login_with create( :user )
        get :index
        expect( response ).to render_template( :index )
      end
    end

    context 'when user is logged out' do
      before do
        login_with nil
        get :index
      end
      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  login_user

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "Update should change current user info" do
    let(:attr) do 
      { username: 'New username', phone: "999-999-999" }
    end

    before(:each) do
      post :update, current_user: attr
    end

      it { expect(response).to redirect_to(user_profile_url) }
      it { expect(controller.current_user.username).to eql attr[:username] }
      it { expect(controller.current_user.phone).to eql attr[:phone] }
      
  end

end
