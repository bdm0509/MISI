class TextBlock < ApplicationRecord
  validates :name, :text_block, :presence => true
end
