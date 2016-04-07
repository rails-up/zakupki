RSpec.shared_context 'unauthenticated' do
  it 'redirects to login' do
    expect(response).to redirect_to(new_user_session_path)
  end
end
