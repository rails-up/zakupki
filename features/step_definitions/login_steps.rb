Given "I'm unauthenticated visitor and I'm on any page" do
  visit root_path
end

When "click link $name" do |arg1|
  click_link arg1
end

Then "the form with fields: $n, $n and link $n appears" do |arg1, arg2, arg3|
  expect(page).to have_content arg3
  expect(page).to have_css("input[type=\"#{arg1}\"]")
  expect(page).to have_css("input[type=\"#{arg2}\"]")
end

Given "I'm unauthenticated visitor" do
  @user=nil
  visit user_session_path
end

Given "I see sign_in form" do
  expect(page).to have_css('form.new_user')
end

Given "I have user's credentials" do
  @user = FactoryGirl.create :user
end

When "fill in $n and $n and click $n" do |arg1, arg2, arg3|
  if @user
    email = @user.email
    password = @user.password
  else
    email = 'email'
    password = 'password'
  end

  find(:css, "input[type=\"#{arg1}\"]").set(email)
  find(:css, "input[type=\"#{arg2}\"]").set(password)
  click_button(arg3)
end

Then "I should be redirected to page $n and see the message $n" do |arg1, arg2|
  expect(page.body).to have_content(arg1)
  expect(page.body).to have_content(arg2)
end

Then "I should see the message $n" do |arg1|
  expect(page.body).to have_content(arg1)
end

