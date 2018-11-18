Feature: Create, find, view, update, and delete maintenance funds/associations

As a MISI user
I want to be able to administrate maintenance funds/associations
So that I can ... (be really cool)

Scenario: A user sees the Maintenance Funds link on the home page navigation menu
  When I go to the homepage
  Then I should a navigation menu item called "Maintenance Funds"
  
@javascript
Scenario: A user visits the Maintenance Funds administration page using the home page navigation menu
  Given there is 1 maintenance fund that already exists
  When I go to the homepage
  And I click the "Maintenance Funds" link on the navigation menu
  Then I should see "Maintenance Funds/Associations Listings"
  And I should see a Search box for Maintenance Funds
  And I should see the correct information for the existing maintenance fund
  
@javascript
Scenario: A user visits the Maintenance Funds administration page and views a maintenance fund's contact information
  Given there is 1 maintenance fund that already exists
  When I go to the homepage
  And I click the "Maintenance Funds" link on the navigation menu
  And I click the "Contact Information" link for the first maintenance fund
  Then I should see the contact information for the first maintenance fund
  
Scenario: A user visits the Maintenance Funds administration page and views the details for a maintenance fund
  Given there is 1 maintenance fund that already exists
  When I go to the homepage
  And I click the "Maintenance Funds" link on the navigation menu
  And I view the details for the first maintenance fund
  Then I should see a correct form for editing a maintenance fund with the correct fields filled out for the first maintenance fund
  
Scenario: A user updates an Assured's details
  Given there is 1 maintenance fund that already exists
  When I visit the page on which I can edit that maintenance fund
  And I update the information for that maintenance fund
  And I press "Update Maintenance fund"
  Then I should see "Maintenance Fund/Association updated."
  And I should see a correct form for editing a maintenance fund with the correct fields filled out for the first maintenance fund