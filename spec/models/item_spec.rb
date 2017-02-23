require 'rails_helper'

RSpec.describe Item, type: :model do
  # associations
  it { is_expected.to belong_to :todo }

  # validations
  it { is_expected.to validate_presence_of :name }
end
