require 'rails_helper'

RSpec.describe Todo, type: :model do
  # associations
  it { is_expected.to have_many(:items).dependent(:destroy) }
  it { is_expected.to belong_to(:user) }

  # validations
  it { is_expected.to validate_presence_of :title }
end
