require 'rails_helper'

RSpec.describe Todo, type: :model do
  # associations
  it { is_expected.to have_many(:items).dependent(:destroy) }

  # validations
  it { is_expected.to validate_presence_of :title }
end
