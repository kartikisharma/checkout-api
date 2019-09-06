class Item < ApplicationRecord
  validates_presence_of :name
  validates :available, inclusion: { in: [true, false] }
end
