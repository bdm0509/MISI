class TextBlock < ActiveRecord::Base
  validates :name, :text_block, :presence => true
end
