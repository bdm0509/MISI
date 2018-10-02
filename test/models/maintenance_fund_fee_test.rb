require 'test_helper'

class MaintenanceFundFeeTest < ActiveSupport::TestCase
  def setup
    @fee_collection_type = fee_collection_types(:upfront_fee_collection)
    @maintenance_fund = maintenance_funds(:main_fund)
    
    @maintenance_fund_fee = MaintenanceFundFee.new(year: 2018, amount: "$56.12")
    @maintenance_fund_fee.fee_collection_type = @fee_collection_type
    @maintenance_fund_fee.maintenance_fund = @maintenance_fund
    
    @other_maintenance_fund_fee = MaintenanceFundFee.new(year: 2016, amount: "$21.21")
    @other_maintenance_fund_fee.fee_collection_type = @fee_collection_type
    @other_maintenance_fund_fee.maintenance_fund = @maintenance_fund
  end
  
  test "both maintenance fund fees should be valid" do
    assert @maintenance_fund_fee.valid?
    assert @other_maintenance_fund_fee.valid?
  end
  
  test "year should be present" do
    @maintenance_fund_fee.year = nil
    assert_not @maintenance_fund_fee.valid?
  end
  
  test "year should be greater than 0" do
    @maintenance_fund_fee.year = 0
    assert_not @maintenance_fund_fee.valid?
    
    @maintenance_fund_fee.year = -100
    assert_not @maintenance_fund_fee.valid?
  end
  
  test "year should be an integer" do
    @maintenance_fund_fee.year = 123.5
    assert_not @maintenance_fund_fee.valid?
  end
  
  test "amount should be present" do
    @maintenance_fund_fee.amount = ""
    assert_not @maintenance_fund_fee.valid?
  end
  
  test "Maintenance Fund Fees must have a fee collection type" do
    @maintenance_fund_fee.fee_collection_type = nil
    assert_not @maintenance_fund_fee.valid?
  end
  
  test "Maintenance Fund Fees must have a maintenance fund" do
    @maintenance_fund_fee.maintenance_fund = nil
    assert_not @maintenance_fund_fee.valid?
  end
end
