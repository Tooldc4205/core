@api @TestAlsoOnExternalUserBackend @skipOnOcis @issue-ocis-reva-14
Feature: move (rename) folder
  As a user
  I want to be able to move and rename folders
  So that I can quickly manage my file system

  Background:
    Given using OCS API version "1"
    And user "user0" has been created with default attributes and skeleton files

  Scenario Outline: Renaming a folder to a backslash should return an error
    Given using <dav_version> DAV path
    And user "user0" has created folder "/testshare"
    When user "user0" moves folder "/testshare" to "\" using the WebDAV API
    Then the HTTP status code should be "400"
    And user "user0" should see the following elements
      | /testshare/ |
    Examples:
      | dav_version |
      | old         |
      | new         |

  Scenario Outline: Renaming a folder beginning with a backslash should return an error
    Given using <dav_version> DAV path
    And user "user0" has created folder "/testshare"
    When user "user0" moves folder "/testshare" to "\testshare" using the WebDAV API
    Then the HTTP status code should be "400"
    And user "user0" should see the following elements
      | /testshare/ |
    Examples:
      | dav_version |
      | old         |
      | new         |

  Scenario Outline: Renaming a folder including a backslash encoded should return an error
    Given using <dav_version> DAV path
    And user "user0" has created folder "/testshare"
    When user "user0" moves folder "/testshare" to "/hola\hola" using the WebDAV API
    Then the HTTP status code should be "400"
    And user "user0" should see the following elements
      | /testshare/ |
    Examples:
      | dav_version |
      | old         |
      | new         |

  Scenario Outline: Move a folder into a not existing one
    Given using <dav_version> DAV path
    And user "user0" has created folder "/testshare"
    When user "user0" moves folder "/testshare" to "/not-existing/testshare" using the WebDAV API
    Then the HTTP status code should be "409"
    And user "user0" should see the following elements
      | /testshare/ |
    Examples:
      | dav_version |
      | old         |
      | new         |
