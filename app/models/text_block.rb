<<<<<<< HEAD
class TextBlock < ApplicationRecord
  validates :name, :text_block, :presence => true
  
  HOME_PAGE_TEXT_KEY = "HOME_PAGE_TEXT"
=======
class TextBlock < ActiveRecord::Base
  validates :name, :text_block, :presence => true
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
end
