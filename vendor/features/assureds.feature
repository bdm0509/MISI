Feature: Create, find, view, update, and delete assureds

As a MISI user
I want to be able to administrate assureds
So that I can ... (be awesome)

Scenario: A user sees the Assureds link on the home page navigation menu
  When I go to the homepage
  Then I should a navigation menu item called "Assureds"
  
@javascript
Scenario: A user visits the Assureds administration page using the home page navigation menu
  Given there is 1 assured that already exists
  When I go to the homepage
  And I click the "Assureds" link on the navigation menu
  Then I should see "Assureds Listings"
  And I should see a Search box for Assureds
  And I should see the correct information for the existing assured
  
@javascript
Scenario: A user visits the Assureds administration page and views an assureds contact information
  Given there is 1 assured that already exists
  When I go to the homepage
  And I click the "Assureds" link on the navigation menu
  And I click the "Contact Information" link for the first assured
  Then I should see the contact information for the first assured
  
Scenario: A user visits the Assureds administration page and views the details for an assured
  Given there is 1 assured that already exists
  When I go to the homepage
  And I click the "Assureds" link on the navigation menu
  And I view the details for the first assured
  Then I should see a correct form for editing an assured with the correct fields filled out for the first assured

@javascript
Scenario: A user visits the Assureds administration page and sees the correct default value for an Assured's fee
  When I go to the homepage
  And I click the "Assureds" link on the navigation menu
  And I press the button to create a new Assured
  Then I should see a correct form for adding an assured
  And I should see a value of 67.12 for the Assured's fee
  
Scenario: A user updates an Assured's details
  Given there is 1 assured that already exists
  When I visit the page on which I can edit that assured
  And I update the information for that assured
  And I press "Update Assured"
  Then I should see "Assured updated."
  And I should see a correct form for editing an assured with the correct fields filled out for the first assured

@javascript  
Scenario: A user tries to supply a non-numeric value for an Assured's fee and sees an error message
  Given there is 1 assured that already exists
  When I visit the page on which I can edit that assured
  And I fill in "My Awesome Assured" for "Title"
  And I fill in "14002 My Street" for "Street"
  And I fill in "Citytown" for "City"
  And I select "Texas" from "State"
  And I fill in "75039" for "Zip"
  And I fill in "Call Me" for "Contact"
  And I fill in "213-242-2312" for "Phone"
  And I fill in "Not a number" for "Fee"
  And I press "Update Assured"
  Then I should see "Please enter a valid number."