require "rails_helper"

RSpec.describe "Api::V1::Devices", type: :request do
  describe "GET /show" do
    let!(:device) { create(:device, uuid: "123abc123") }
    let!(:reading_1) { create(:reading, timestamp: "2021-09-29T14:00:00+01:00", count: 10, device: device) }
    let!(:reading_2) { create(:reading, timestamp: "2021-09-29T15:00:00+01:00", count: 15, device: device) }

    let(:subject) { get api_v1_device_path(id: device.uuid), as: :json }

    it "returns the expected information" do
      subject
      expect(JSON.parse(response.body)).to eq(
        {
          "device" => {
            "uuid" => "123abc123",
            "cumulative" => 25,
            "most_recent_reading" => {
              "timestamp" => "2021-09-29T14:00:00.000Z",
              "count" => 15
            }
          }
        }
      )
    end
  end
end
