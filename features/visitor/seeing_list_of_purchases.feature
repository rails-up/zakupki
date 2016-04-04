Feature: Seeing list of purchases
  In order to participate in purchases
  As a visitor
  I want to see all open purchases

  Scenario: Seeing all open purchases
    Given I'm on any page
    And open purchases exist
    When I click on link "Закупки"
    Then I see the table with name "открытые закупки" that has fields: "Название", "Город", "Краткое описание", "Сбор заявок до"
    And there is at least one row in this table

  Scenario: Seeing no purchases
    Given I'm on any page
    And open purchases don't exist
    When I click on link "Закупки"
    Then I see the text "Нет ни одной закупки по выбранным вами критериям"

  Scenario: Seeing open puchases within group
    Given I'm on page "Группы"
    And open purchases exist
    When I click on row where last coloumn named "Количество активных закупок" has the value more than "1"
    Then I'm get to group's page
    And Then I see the table with name "открытые закупки" that has fields: "Название", "Краткое описание", "Сбор заявок до"

  Scenario: Seeing no puchases within group
    Given I'm on page "Группы"
    And there is at least one group with no purchases
    When I click on row where last coloumn named "Количество активных закупок" has the value "0"
    Then I'm get to group's page
    And Then I see the text "В данной группе пока нет ни одной активной закупки"
  
  
  
  
  
  
  
  
  

  
