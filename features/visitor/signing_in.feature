Feature: signing in
  In order to paricipate in purchase
  As a visitor
  I want to sign in

  Scenario: open sign_in form
    Given I'm unauthenticated visitor and I'm on any page
    When click link Вход / Регистрация
    Then the form with fields: email, password and link Вход через Vkontakte appears

  Scenario: successful sign_in as user
    Given I'm unauthenticated visitor
    And I see sign_in form
    And I have user's credentials
    When fill in email and password and click Войти
    Then I should be redirected to page Активные закупки and see the message Вход в систему выполнен

  Scenario: unsuccessful sign_in
    Given I'm unauthenticated visitor
    And I see sign_in form
    When fill in email and password and click Войти
    Then I should see the message Неверный email или пароль
