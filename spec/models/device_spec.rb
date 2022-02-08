require "rails_helper"

RSpec.describe Device, type: :model do
  subject { create(:device) }
  it { is_expected.to have_many(:readings) }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_uniqueness_of(:uuid) }
end
