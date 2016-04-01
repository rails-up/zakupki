Given "I'm unauthenticated visitor and I'm on any page" do
  visit root_path
end

When "click link $name" do |arg1|
 p I18n.t('nav')
 click_link arg1
end

Then(/^the form with fields: email, password and link "([^"]*)" appear$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I'm unautentificated visitor$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I see sign_in form$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I have user's credentials$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^fill in <email> and <password> and click "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should be redirected to page "([^"]*)" and see the message "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I have organizer's credentials$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I'm unautentificated visitor and I see sign_in form$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the message "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

