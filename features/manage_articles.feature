Feature: Gerenciar artigos
  Para fazer um blog
  Como um autor
  Eu quero criar e gerenciar artigos

  Scenario: Articles List
    Given I have articles titled Pizza, Breadsticks
    When I go to the list articles
    Then I should see "Pizza"
    And I should see "Breadsticks"

  Scenario: Create Valid Article
    Given I have no articles
    And I am on the list of articles
    When I follow "New Article"
    And I fill in "Title" with "Spuds"
    And I fill in "Content" with "Delicious potato wedges!"
    And I press "Create"
    Then I should see "New article created."
    And I should see "Spuds"
    And I should see "Delicious potato wedges!"
    And I should have 1 article

  Scenario: Get the Articles List via JSON API
    Given I have no articles
    And I am on the list of articles
    When I follow "New Article"
    And I fill in "Title" with "Spuds"
    And I fill in "Content" with "Delicious potato wedges!"
    And I press "Create"
    Then I should see "New article created."
    And I should see "Spuds"
    And I should see "Delicious potato wedges!"
    And I should have 1 article
    And I am on the list of articles
    When I follow "New Article"
    And I fill in "Title" with "Spuds2"
    And I fill in "Content" with "Delicious potato wedges!"
    And I press "Create"
    Then I should see "New article created."
    And I should see "Spuds2"
    And I should see "Delicious potato wedges!"
    And I should have 2 article
    And I send and accept JSON
    When I send a GET request for "/api/articles"
    Then the response should be "200"
    And the JSON response should be an array with 2 "article" elements

  Scenario: Post a new Article via JSON API
    Given I have no articles
    And I am on the list of articles
    When I follow "New Article"
    And I fill in "Title" with "Spuds"
    And I fill in "Content" with "Delicious potato wedges!"
    And I press "Create"
    Then I should see "New article created."
    And I should see "Spuds"
    And I should see "Delicious potato wedges!"
    And I should have 1 article
    And I send and accept JSON
    When I send a POST request to "/api/articles" with the following: 
      """
      {"article":{"title":"titulo","content":"Conteudo"}}
      """
    Then the response should be "201"
    And the JSON response should be "article" element
