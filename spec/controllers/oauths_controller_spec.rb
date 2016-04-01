require 'rails_helper'

RSpec.describe OauthsController, type: :controller do

  describe "GET #vkontakte" do
    it "returns http success" do
      get :vkontakte
      expect(response).to have_http_status(:success)
    end
  end

end
