# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Connect::Device do
  let(:raw_data) do
    {
      id:             "941223d904f006c4d998598272d43d94",
      is_active:      true,
      is_restricted:  false,
      name:           "Bilawal's Macbook Pro",
      type:           "Computer",
      volume_percent: 100
    }
  end
  let(:session) { build(:session, access_token: "access_token") }
  let(:sdk) { Spotify::SDK.new(session) }
  let(:connect_sdk) { Spotify::SDK::Connect.new(sdk) }
  subject { Spotify::SDK::Connect::Device.new(raw_data, connect_sdk) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  describe "#transfer_playback!" do
    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player")
             .with(body:    {device_ids: [raw_data[:id]], play: true}.to_json,
                   headers: {Authorization: "Bearer access_token"})

      subject.transfer_playback!
      expect(stub).to have_been_requested
    end
  end

  describe "#transfer_state!" do
    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player")
             .with(body:    {device_ids: [raw_data[:id]], play: false}.to_json,
                   headers: {Authorization: "Bearer access_token"})

      subject.transfer_state!
      expect(stub).to have_been_requested
    end
  end

  context "Method Missing" do
    it "connects method calls to raw_data" do
      raw_data.each do |key, value|
        expect(subject.send(key)).to eq value
      end
    end
  end
end
