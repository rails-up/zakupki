module ControllerMacros
  def sign_in_user
    before do
      @user = create :user
      @request.env['devise.mapping'] = Devise.mappings[:user]
      login_with @user
      allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource)
    end
  end
end
