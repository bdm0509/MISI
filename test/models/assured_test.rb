require 'test_helper'

class AssuredTest < ActiveSupport::TestCase
  def setup
    @assured = Assured.new(title: "Assured 1", 
                           street: "Street 1", city: "City 1", zip: "12345", state: "TX", 
                           phone: "2142871111", contact: "Mary Malone", fee: 61.23)
    @second_assured = Assured.new(title: "Assured 2", 
                           street: "Street 2", city: "City 2", zip: "12345", state: "TX", 
                           phone: "4056546541", contact: "Bob Ross", fee: 99.99)
  end
  
  test "both assureds should be valid" do
    assert @assured.valid?
    assert @second_assured.valid?
  end
  
  test "title should be present" do
    @assured.title = ""
    assert_not @assured.valid?
  end
  
  test "street should be present" do
    @assured.street = ""
    assert_not @assured.valid?
  end
  
  test "city should be present" do
    @assured.city = ""
    assert_not @assured.valid?
  end
  
  test "zip should be present" do
    @assured.zip = ""
    assert_not @assured.valid?
  end
  
  test "state should be present" do
    @assured.state = ""
    assert_not @assured.valid?
  end
  
  test "phone should be present" do
    @assured.phone = ""
    assert_not @assured.valid?
  end
  
  test "contact should be present" do
    @assured.contact = ""
    assert_not @assured.valid?
  end
  
  test "fee should be present" do
    @assured.fee = nil
    assert_not @assured.valid?
  end
  
  test "fee should be greater than 0" do
    @assured.fee = -0.123
    assert_not @assured.valid?
  end
end
