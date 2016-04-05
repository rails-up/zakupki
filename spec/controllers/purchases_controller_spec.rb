require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do

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
        get :new
      end
      it { is_expected.to redirect_to root_path }
    end
  end

  login_user

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
end
