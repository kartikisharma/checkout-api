require 'rails_helper'

RSpec.describe Item, type: :model do

  # Validation tests
  # ensure cols name and available are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:barcode) }
end
