require "rails_helper"

RSpec.describe "Api::V1::Readings", type: :request do
  describe "POST /create" do
    let(:subject) { post api_v1_readings_path, params: params, as: :json }
    let(:params) {
      {
        uuid: "123abc123",
        readings: [
          {
            timestamp: "2021-09-29T14:00:00+01:00",
            count: 10
          }, {
            timestamp: "2021-09-29T15:00:00+01:00",
            count: 15
          }
        ]
      }
    }

    context "when the device doesn't exist" do
      it "creates the device" do
        expect { subject }.to change { Device.count }.by(1)
        expect(Device.first.uuid).to eq("123abc123")
      end

      it "creates the readings" do
        expect { subject }.to change { Reading.count }.by(2)
        expect(Reading.first.timestamp).to eq(Time.zone.parse("2021-09-29T14:00:00+01:00"))
        expect(Reading.first.count).to eq(10)
        expect(Reading.second.timestamp).to eq(Time.zone.parse("2021-09-29T15:00:00+01:00"))
        expect(Reading.second.count).to eq(15)
      end

      it "returns the expected information" do
        subject
        expect(JSON.parse(response.body)).to eq(
          {
            "device" => {
              "uuid" => "123abc123",
              "readings" => [
                {"timestamp" => "2021-09-29T13:00:00.000Z", "count" => 10},
                {"timestamp" => "2021-09-29T14:00:00.000Z", "count" => 15}
              ]
            }
          }
        )
      end
    end

    context "when the device exists" do
      let!(:device) { create(:device, uuid: "123abc123") }

      it "doesn't create the device" do
        expect { subject }.not_to change { Device.count }
      end

      it "creates the readings" do
        expect { subject }.to change { Reading.count }.by(2)
        expect(Reading.first.timestamp).to eq(Time.zone.parse("2021-09-29T14:00:00+01:00"))
        expect(Reading.first.count).to eq(10)
        expect(Reading.second.timestamp).to eq(Time.zone.parse("2021-09-29T15:00:00+01:00"))
        expect(Reading.second.count).to eq(15)
      end

      it "returns the expected information" do
        subject
        expect(JSON.parse(response.body)).to eq(
          {
            "device" => {
              "uuid" => "123abc123",
              "readings" => [
                {"timestamp" => "2021-09-29T13:00:00.000Z", "count" => 10},
                {"timestamp" => "2021-09-29T14:00:00.000Z", "count" => 15}
              ]
            }
          }
        )
      end
    end

    context "when a readings is duplicate" do
      let!(:device) { create(:device, uuid: "123abc123") }
      let!(:reading) { create(:reading, timestamp: "2021-09-29T14:00:00+01:00", count: 10, device: device) }

      it "creates just the new reading" do
        expect { subject }.to change { Reading.count }.by(1)
        expect(Reading.second.timestamp).to eq(Time.zone.parse("2021-09-29T15:00:00+01:00"))
        expect(Reading.second.count).to eq(15)
      end

      it "returns the expected information" do
        subject
        expect(JSON.parse(response.body)).to eq(
          {
            "device" => {
              "uuid" => "123abc123",
              "readings" => [
                {"timestamp" => "2021-09-29T14:00:00.000Z", "count" => 15}
              ]
            }
          }
        )
      end
    end
  end
end
