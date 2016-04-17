module FormHelpers
  def sign_in(email, pass)
    visit (new_user_session_path)
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: pass
    find(:css, "input[type='submit']").click
  end
end
