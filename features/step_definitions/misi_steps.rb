###################################################
#
# Given steps (setup)
#
###################################################
Given /^there (is|are) (.*) assured(s?) that already exist(s?)$/ do |ignored_1, num_assureds, ignored_2, ignored_3|
  @existing_assureds = Array.new
  num_assureds.to_i.times do
    assured = FactoryGirl(:assured)
    @existing_assureds << assured
  end
end

Given /^there (is|are) (.*) maintenance fund(s?) that already exist(s?)$/ do |ignored_1, num_maintenance_funds, ignored_2, ignored_3|
  @existing_maintenance_funds = Array.new
  num_maintenance_funds.to_i.times do
    maintenance_fund = FactoryGirl(:maintenance_fund)
    @existing_maintenance_funds << maintenance_fund
  end
end

###################################################
#
# When steps (action)
#
###################################################
When /^I click the "([^"]*)" link on the navigation menu$/ do |link_name|
  within('ul#navigation_menu') do
    page.find(:xpath, "//a[text()='#{link_name}']").click
  end
end

When /^I click the \"Contact Information\" link for the (first|second|third|that) assured$/ do |which_assured|
  case which_assured
  when "first"
    row_index = 1
  when "that"
    row_index = 1
  when "second"
    row_index = 2
  when "third"
    row_index = 3
  end
  
  within(:xpath, "//table[@id='assureds_table']/tbody/tr[position()=#{row_index}]") do
    click_link("Contact Information")
  end
end

When /^I click the \"Contact Information\" link for the (first|second|third|that) maintenance fund$/ do |which_maintenance_fund|
  case which_maintenance_fund
  when "first"
    row_index = 1
  when "that"
    row_index = 1
  when "second"
    row_index = 2
  when "third"
    row_index = 3
  end
  
  within(:xpath, "//table[@id='maintenance_funds_table']/tbody/tr[position()=#{row_index}]") do
    click_link("Contact Information")
  end
end

When /^I visit the page on which I can edit that assured$/ do
  visit assured_path(@existing_assureds.first)
end

When /^I visit the page on which I can edit that maintenance fund$/ do
  visit maintenance_fund_path(@existing_maintenance_funds.first)
end

When /^I view the details for the (first|second|third|that) assured$/ do |which_assured|
  case which_assured
  when "first"
    assured = @existing_assureds.first
    row_index = 1
  when "that"
    assured = @existing_assureds.first
    row_index = 1
  when "second"
    assured = @existing_assureds.second
    row_index = 2
  when "third"
    assured = @existing_assureds.third
    row_index = 3
  end
  
  within(:xpath, "//table[@id='assureds_table']/tbody/tr[position()=#{row_index}]") do
    click_link("#{assured.title}")
  end
end

When /^I view the details for the (first|second|third|that) maintenance fund$/ do |which_maintenance_fund|
  case which_maintenance_fund
  when "first"
    maintenance_fund = @existing_maintenance_funds.first
    row_index = 1
  when "that"
    maintenance_fund = @existing_maintenance_funds.first
    row_index = 1
  when "second"
    maintenance_fund = @existing_maintenance_funds.second
    row_index = 2
  when "third"
    maintenance_fund = @existing_maintenance_funds.third
    row_index = 3
  end
  
  within(:xpath, "//table[@id='maintenance_funds_table']/tbody/tr[position()=#{row_index}]") do
    click_link("#{maintenance_fund.name}")
  end
end

When /^I update the information for that assured$/ do
  {
    "Title"   => "A newer better title",
    "Street"  => "The path to nowhere",
    "City"    => "My City",
    "Zip"     => "11221",
    "Contact" => "Michael Traugott",
    "Phone"   => "928-867-5309",
    "Fee"     => 12.12
  }.each { |field, value|
    fill_in(field, :with => value)
  }
end

When /^I update the information for that maintenance fund$/ do
  {
    "Name"      => "The new fund name",
    "Collector" => "An awful fund collector",
    "Street"    => "The path to nowhere",
    "City"      => "The fund city",
    "Zip"       => "19203",
    "Contact"   => "Someone Somewhere",
    "Phone"     => "878-192-2403",
    "Instructions" => "Pay close attention",
    "Amenities" => "Water and heat all day long"
  }.each { |field, value|
    fill_in(field, :with => value)
  }
end

When /^I press the button to create a new Assured$/ do
  click_link("create_new_assured")
end

###################################################
#
# Then steps (verification)
#
###################################################
Then /^I should see MISI contact information$/ do
  page.should have_content("9301 Southwest Freeway")
  page.should have_content("Suite 455")
  page.should have_content("Houston, Texas")
  page.should have_content("(713) 270-5660")
end

Then /^I should a navigation menu item called "([^"]*)"$/ do |link_name|
  within('ul#navigation_menu') do
    page.should have_link(link_name)
  end
end

Then /^I should see a Search box for Assureds$/ do
  within('div#assureds div#assureds_table_filter label.datatable') do
    page.should have_content("Search:")
    page.should have_xpath("//input[@type='text']")
  end
end

Then /^I should see a Search box for Maintenance Funds$/ do
  within('div#maintenance_funds div#maintenance_funds_table_filter label.datatable') do
    page.should have_content("Search:")
    page.should have_xpath("//input[@type='text']")
  end
end

Then /^I should see the correct information for the existing assured(s?)$/ do |ignored_plural|
  @existing_assureds.each do |assured|
    within("tr#assured-#{assured.id}") do
      page.should have_content("#{assured.title}")
      page.should have_content("#{assured.street}")
      page.should have_content("#{assured.city}")
      page.should have_content("#{assured.state}")
      page.should have_content("#{assured.zip}")
      page.should have_link("Contact Information")
    end
  end
end

Then /^I should see the correct information for the existing maintenance fund(s?)$/ do |ignored_plural|
  @existing_maintenance_funds.each do |maintenance_fund|
    within("tr#maintenance_fund-#{maintenance_fund.id}") do
      page.should have_content("#{maintenance_fund.name}")
      page.should have_content("#{maintenance_fund.collector}")
      page.should have_content("#{maintenance_fund.street}")
      page.should have_content("#{maintenance_fund.city}")
      page.should have_content("#{maintenance_fund.state}")
      page.should have_content("#{maintenance_fund.zip}")
      page.should have_link("Contact Information")
    end
  end
end

Then /^I should see a correct form for adding an assured$/ do
  page.should have_field("assured_title")
  page.should have_field("assured_street")
  page.should have_field("assured_city")
  page.should have_field("assured_zip")
  page.should have_field("assured_contact")
  page.should have_field("assured_phone")
  page.should have_field("assured_fee")
end

Then /^I should see a correct form for editing an assured with the correct fields filled out for the (first|second|third|that) assured$/ do |which_assured|
  case which_assured
  when "first"
    assured = @existing_assureds.first
  when "that"
    assured = @existing_assureds.first
  when "second"
    assured = @existing_assureds.second
  when "third"
    assured = @existing_assureds.third
  end
  
  assured.reload
  
  page.should have_field("assured_title", :with => "#{assured.title}")
  page.should have_field("assured_street", :with => "#{assured.street}")
  page.should have_field("assured_city", :with => "#{assured.city}")
  page.should have_field("assured_zip", :with => "#{assured.zip}")
  page.should have_field("assured_contact", :with => "#{assured.contact}")
  page.should have_field("assured_phone", :with => "#{assured.phone}")
  page.should have_field("assured_fee", :with => "#{assured.fee}")
end

Then /^I should see a correct form for editing a maintenance fund with the correct fields filled out for the (first|second|third|that) maintenance fund$/ do |which_maintenance_fund|
  case which_maintenance_fund
  when "first"
    maintenance_fund = @existing_maintenance_funds.first
  when "that"
    maintenance_fund = @existing_maintenance_funds.first
  when "second"
    maintenance_fund = @existing_maintenance_funds.second
  when "third"
    maintenance_fund = @existing_maintenance_funds.third
  end
  
  maintenance_fund.reload
  
  page.should have_field("maintenance_fund_name", :with => "#{maintenance_fund.name}")
  page.should have_field("maintenance_fund_collector", :with => "#{maintenance_fund.collector}")
  page.should have_field("maintenance_fund_street", :with => "#{maintenance_fund.street}")
  page.should have_field("maintenance_fund_city", :with => "#{maintenance_fund.city}")
  page.should have_field("maintenance_fund_zip", :with => "#{maintenance_fund.zip}")
  page.should have_field("maintenance_fund_contact", :with => "#{maintenance_fund.contact}")
  page.should have_field("maintenance_fund_phone", :with => "#{maintenance_fund.phone}")
  page.should have_field("maintenance_fund_instructions", :with => "#{maintenance_fund.instructions}")
  page.should have_field("maintenance_fund_amenities", :with => "#{maintenance_fund.amenities}")
end

Then /^I should see the contact information for the (first|second|third|that) assured$/ do |which_assured|
  case which_assured
  when "first"
    assured = @existing_assureds.first
  when "that"
    assured = @existing_assureds.first
  when "second"
    assured = @existing_assureds.second
  when "third"
    assured = @existing_assureds.third
  end
  
  within("#contact_information") do
    page.should have_content("#{assured.title}")
    page.should have_content("#{assured.contact}")
    page.should have_content("#{assured.phone}")
  end
end

Then /^I should see the contact information for the (first|second|third|that) maintenance fund$/ do |which_maintenance_fund|
  case which_maintenance_fund
  when "first"
    maintenance_fund = @existing_maintenance_funds.first
  when "that"
    maintenance_fund = @existing_maintenance_funds.first
  when "second"
    maintenance_fund = @existing_maintenance_funds.second
  when "third"
    maintenance_fund = @existing_maintenance_funds.third
  end
  
  within("#contact_information") do
    page.should have_content("#{maintenance_fund.name}")
    page.should have_content("#{maintenance_fund.contact}")
    page.should have_content("#{maintenance_fund.phone}")
  end
end

Then /^I should see a value of (.*) for the Assured's fee$/ do |fee|
  page.should have_field("assured_fee", :with => fee)
end

###################################################
#
# Utilities
#
###################################################
AfterStep('@pause') do
  print "Press <Return> to continue."
  STDIN.getc
end