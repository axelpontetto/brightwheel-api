require "rails_helper"

RSpec.describe Reading, type: :model do
  it { is_expected.to belong_to(:device) }
  it { is_expected.to validate_presence_of(:timestamp) }
  it { is_expected.to validate_presence_of(:count) }
end
