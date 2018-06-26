# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Connect do
  let(:session) { build(:session, access_token: "access_token") }
  let(:connect_sdk) { Spotify::SDK.new(session).connect }

  describe "#playback" do
    before(:each) do
      stub_spotify_api_request(fixture:  "get/v1/me/player/currently-playing/valid-response",
                               method:   :get,
                               endpoint: "/v1/me/player?market=from_token")
    end

    it "should return a Spotify::SDK::Connect::PlaybackState object" do
      expect(connect_sdk.playback).to be_kind_of(Spotify::SDK::Connect::PlaybackState)
    end

    it "should contain the correct values" do
      expect(connect_sdk.playback.to_h).to eq read_fixture("get/v1/me/player/currently-playing/valid-response")
    end
  end

  describe "#devices" do
    before(:each) do
      stub_spotify_api_request(fixture:  "get/v1/me/player/devices/active-list",
                               method:   :get,
                               endpoint: "/v1/me/player/devices")
    end

    it "should return an list of devices with the device object" do
      expect(connect_sdk.devices).to be_kind_of(Array)
    end

    it "should contain the correct values" do
      device = connect_sdk.devices[0]
      expect(device).to be_kind_of(Spotify::SDK::Connect::Device)
      expect(device.to_h).to eq read_fixture("get/v1/me/player/devices/active-list")[:devices][0]
    end
  end

  describe "#active_devices" do
    it "should return an empty list of devices if no active devices" do
      stub_spotify_api_request(fixture:  "get/v1/me/player/devices/inactive-list",
                               method:   :get,
                               endpoint: "/v1/me/player/devices")

      expect(connect_sdk.active_devices).to be_kind_of(Array).and eq []
    end

    it "should return a two active devices if two active devices" do
      stub_spotify_api_request(fixture:  "get/v1/me/player/devices/active-list",
                               method:   :get,
                               endpoint: "/v1/me/player/devices")

      expect(connect_sdk.active_devices).to be_kind_of(Array)
      expect(connect_sdk.active_devices.count).to eq(2)
    end
  end

  describe "#active_device" do
    it "should return a nil if no active devices" do
      stub_spotify_api_request(fixture:  "get/v1/me/player/devices/inactive-list",
                               method:   :get,
                               endpoint: "/v1/me/player/devices")
      expect(connect_sdk.active_device).to be_nil
    end

    it "should return a device object if at least one active device" do
      stub_spotify_api_request(fixture:  "get/v1/me/player/devices/active-list",
                               method:   :get,
                               endpoint: "/v1/me/player/devices")

      device = connect_sdk.active_device
      expect(device).to be_kind_of(Spotify::SDK::Connect::Device)
      expect(device.id).to eq "941223d904f006c4d998598272d43d94"
      expect(device.is_active).to eq true
      expect(device.is_restricted).to eq false
      expect(device.name).to eq "Bilawal’s MacBook Pro"
      expect(device.type).to eq "Computer"
      expect(device.volume_percent).to eq 100
    end
  end
end
