Feature: Merge Article
  As a blog administrator
  In order to union similar articles
  I want to be able to merge articles

  Background:
    Given the blog is set up

  Scenario: 1-A non-admin cannot merge articles
    Given I am logged as publisher into the admin panel
    When I am on the edit page of article "Artigo 2"
    Then I should not see "Merge Articles"

  Scenario: 1-An admin should see merge articles option
    Given I am logged as admin into the admin panel
    When I am on the edit page of article "Artigo 1"
    Then I should see "Merge Articles"

  Scenario: 2-When articles are merged they should have text of both articles
    Given I am logged as admin into the admin panel
    When I merge two articles
    Then new article should have text from both articles

  Scenario: 3-When articles are merged they should have one author
    Given I am logged as admin into the admin panel
    When I merge two articles
    Then new article should have one author

  Scenario: 4-Comments on each of the two original articles need to all carry over
    Given I am logged as admin into the admin panel
    When I merge two articles
    Then new article should have all comments from original articles

  Scenario: 5-The title of the new article should be the title from either one of the merged articles
    Given I am logged as admin into the admin panel
    When I merge two articles
    Then the title of new article should contain original articles title