require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  context 'authenticated access' do
    before { login_with create(:user_with_nine_purchases) }

    describe 'GET#index' do
      it "renders index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  context 'unauthenticated access' do
    before { login_with nil }
    describe 'GET#new' do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  login_user

  describe "GET#edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
end
