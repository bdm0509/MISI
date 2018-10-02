require 'test_helper'

class TextBlockTest < ActiveSupport::TestCase
  def setup
    @text_block = TextBlock.new(name: "Text Block 1", text_block: "Block of Text 1")
    @other_text_block = TextBlock.new(name: "Text Block 2", text_block: "Block of Text 2")
  end
  
  test "both text blocks should be valid" do
    assert @text_block.valid?
    assert @other_text_block.valid?
  end
  
  test "name should be present" do
    @text_block.name = ""
    assert_not @text_block.valid?
  end
  
  test "text_block should be present" do
    @text_block.text_block = ""
    assert_not @text_block.valid?
  end
end
