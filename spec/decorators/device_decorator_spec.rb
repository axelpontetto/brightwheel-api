require "rails_helper"

RSpec.describe DeviceDecorator do
  let!(:device) { create(:device, uuid: "123abc123") }
  let!(:reading_1) { create(:reading, timestamp: "2021-09-29T14:00:00+01:00", count: 10, device: device) }
  let!(:reading_2) { create(:reading, timestamp: "2021-09-29T15:00:00+01:00", count: 15, device: device) }
  let(:decorated_device) { device.decorate }

  it "returns cumulative" do
    expect(decorated_device.cumulative).to eq(25)
  end

  it "returns most recent reading" do
    expect(decorated_device.most_recent_reading).to eq(reading_2)
  end
end
