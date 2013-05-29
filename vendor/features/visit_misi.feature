Feature: Visit, login, and logout of the MISI Web application

As a MISI user
I want to be able to login and logout of the MISI Web application
So that I can securely use the application

Scenario: A user visits the MISI Web application
  When I go to the homepage
  Then I should see MISI contact information
  And I should see "Welcome to MISI"