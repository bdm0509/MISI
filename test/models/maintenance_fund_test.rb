require 'test_helper'

class MaintenanceFundTest < ActiveSupport::TestCase
  def setup
    @maintenance_fund = MaintenanceFund.new(name: "Assured 1")
    @other_maintenance_fund = MaintenanceFund.new(name: "Assured 2")
  end
  
  test "both maintenance funds should be valid" do
    assert @maintenance_fund.valid?
    assert @other_maintenance_fund.valid?
  end
  
  test "name should be present" do
    @maintenance_fund.name = ""
    assert_not @maintenance_fund.valid?
  end
end
