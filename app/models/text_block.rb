class TextBlock < ApplicationRecord
  validates :name, :text_block, :presence => true
  
  HOME_PAGE_TEXT_KEY = "HOME_PAGE_TEXT"
end
