Feature: Seeing list of groups
  In order to find interesting puschases
  As a visitor
  I want to see all existed groups

  Scenario: Seeing all groups
    Given I am on any page
    And  at least one group exists
    When I click on on link "Группы"
    Then I see the table with records with columns: "Город", "Название", "Участников", "Количество активных закупок" sorted by column "Количество активных закупок" descending

  Scenario: Seeing no groups
    Given I am on any page
    And  there are no groups
    When I click on on link "Группы"
    Then Instead of the table I see the text "Пока ещё не создано ни одной группы" 

  Scenario: Filtering groups by city with search results
    Given I am on page "Группы"
    And there is at least one group in city "Санкт-Петербург"
    When I choose "Санкт-Петербург" in dropdown list and press the button "фильтровать"
    Then I see the table with records and with columns: "Город", "Название", "Участников", "Количество активных закупок" sorted by column "Количество активных закупок" descending

  Scenario: Filtering groups by city without search results
    Given I am on page "Группы"
    And there are no groups in city "Колыма"
    When I choose "Колыма" in dropdown list and press the button "фильтровать"
    Then Instead of the table I see the text "В городе Колыма нет ни одной группы"

  Scenario: Filtering groups by city without search results
    Given I am on page "Группы"
    And there are at least one group    When I choose "Колыма" in dropdown list and press the button "фильтровать"
    Then Instead of the table I see the text "В городе Колыма нет ни одной группы"
 

 
 
  
  
  
  
  
  