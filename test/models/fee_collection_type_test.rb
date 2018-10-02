require 'test_helper'

class FeeCollectionTypeTest < ActiveSupport::TestCase
  def setup
    @fee_collection_type = FeeCollectionType.new(type_string: "Type 1", description: "Description 1")
    @other_fee_collection_type = FeeCollectionType.new(type_string: "Type 2", description: "Description 2")
  end
  
  test "both fee collection types should be valid" do
    assert @fee_collection_type.valid?
    assert @other_fee_collection_type.valid?
  end
  
  test "type_string should be present even if set to blank" do
    @fee_collection_type.type_string = ""
    description = @fee_collection_type.description
    assert @fee_collection_type.valid?
    assert @fee_collection_type.type_string == description.gsub(/\s+/, "").upcase
  end
  
  test "description should be present" do
    @fee_collection_type.description = ""
    assert_not @fee_collection_type.valid?
  end
end
