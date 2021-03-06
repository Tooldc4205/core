@cli @skipOnLDAP
Feature: get groups
  As an admin
  I want to be able to get a list of groups
  So that I can see all the groups in my ownCloud

  @issue-user_ldap-500
  Scenario: admin gets all the groups
    Given group "0" has been created
    And group "new-group" has been created
    And group "España" has been created
    When the administrator gets the groups in JSON format using the occ command
    Then the command should have been successful
    And the groups returned by the occ command should be
      | group     |
      | España    |
      | admin     |
      | new-group |
      | 0         |

  @issue-user_ldap-499
  Scenario: admin gets all the groups, including groups with mixed case
    Given group "new-group" has been created
    And group "New-Group" has been created
    And group "NEW-GROUP" has been created
    When the administrator gets the groups in JSON format using the occ command
    Then the command should have been successful
    And the groups returned by the occ command should be
      | group     |
      | admin     |
      | new-group |
      | New-Group |
      | NEW-GROUP |
