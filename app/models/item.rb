class Item < ApplicationRecord
  validates_presence_of :name, :barcode
  validates :available, inclusion: { in: [true, false] }
end
