class Item < ApplicationRecord
  # model association
  belongs_to :todo

  # validations
  validates :name, presence: true
end
