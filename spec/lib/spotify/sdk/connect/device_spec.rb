# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Connect::Device do
  let(:raw_data)    { read_fixture("get/v1/me/player/devices/active-list")[:devices][0] }
  let(:session)     { build(:session, access_token: "access_token") }
  let(:connect_sdk) { Spotify::SDK::Connect.new(Spotify::SDK.new(session)) }
  subject           { Spotify::SDK::Connect::Device.new(raw_data, connect_sdk) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  describe "#playback" do
    before(:each) do
      stub_spotify_api_request(fixture:  "get/v1/me/player/currently-playing/public-session",
                               method:   :get,
                               endpoint: "/v1/me/player?market=from_token")
    end

    it "is an alias for Spotify::SDK::Connect#playback" do
      expect(subject.playback).to eq connect_sdk.playback
    end
  end

  describe "#volume" do
    it "is an alias for volume_percent" do
      expect(subject.volume).not_to be_nil
      expect(subject.volume).to be subject.volume_percent
    end
  end

  describe "#active?" do
    it "is an alias for is_active" do
      expect(subject.active?).not_to be_nil
      expect(subject.active?).to be subject.is_active
    end
  end

  describe "#private_session?" do
    it "is an alias for is_private_session" do
      expect(subject.private_session?).not_to be_nil
      expect(subject.private_session?).to be subject.is_private_session
    end
  end

  describe "#restricted?" do
    it "is an alias for is_restricted" do
      expect(subject.restricted?).not_to be_nil
      expect(subject.restricted?).to be subject.is_restricted
    end
  end

  describe "#play!" do
    it "from context and an index, should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/play?device_id=#{raw_data[:id]}")
             .with(body:    {context_uri: "spotify:album:5ht7ItJgpBH7W6vJ5BqpPr", offset: {position: 5}}.to_json,
                   headers: {Authorization: "Bearer access_token"})

      subject.play!(index: 5, context: "spotify:album:5ht7ItJgpBH7W6vJ5BqpPr")
      expect(stub).to have_been_requested
    end

    it "from a uri, should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/play?device_id=#{raw_data[:id]}")
             .with(body:    {uris: ["spotify:track:5MqkZd7a7u7N7hKMqquL2U"]}.to_json,
                   headers: {Authorization: "Bearer access_token"})

      subject.play!(uri: "spotify:track:5MqkZd7a7u7N7hKMqquL2U")
      expect(stub).to have_been_requested
    end

    it "from a context and uri, should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/play?device_id=#{raw_data[:id]}")
             .with(body:    {
               context_uri: "spotify:album:5ht7ItJgpBH7W6vJ5BqpPr",
               offset:      {uri: "spotify:track:5MqkZd7a7u7N7hKMqquL2U"}
             }.to_json,
                   headers: {Authorization: "Bearer access_token"})

      subject.play!(uri: "spotify:track:5MqkZd7a7u7N7hKMqquL2U", context: "spotify:album:5ht7ItJgpBH7W6vJ5BqpPr")
      expect(stub).to have_been_requested
    end

    it "from a uri and index, should throw an error" do
      expect {
        subject.play!(uri: "spotify:track:5MqkZd7a7u7N7hKMqquL2U", index: 5)
      }.to raise_error(/Unrecognized play instructions/)
    end
  end

  describe "#resume!" do
    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/play?device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.resume!
      expect(stub).to have_been_requested
    end
  end

  describe "#pause!" do
    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/pause?device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.pause!
      expect(stub).to have_been_requested
    end
  end

  describe "#previous!" do
    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/previous?device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.previous!
      expect(stub).to have_been_requested
    end
  end

  describe "#next!" do
    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/next?device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.next!
      expect(stub).to have_been_requested
    end
  end

  describe "#volume=" do
    it "should only accept an integer" do
      expect {
        subject.volume = true
      }.to raise_error(/Must be an integer/)
    end

    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/volume?volume_percent=28&device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.volume = 28
      expect(stub).to have_been_requested
    end
  end

  describe "#change_volume!" do
    it "requires a parameter" do
      expect {
        subject.change_volume!
      }.to raise_error ArgumentError, /wrong number of arguments/
    end

    it "should only accept an integer" do
      expect {
        subject.change_volume!(true)
      }.to raise_error(/Must be an integer/)
    end

    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/volume?volume_percent=28&device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.change_volume!(28)
      expect(stub).to have_been_requested
    end
  end

  describe "#position_ms=" do
    it "should only accept an integer" do
      expect {
        subject.position_ms = true
      }.to raise_error(/Must be an integer/)
    end

    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/seek?position_ms=123456&device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.position_ms = 123_456
      expect(stub).to have_been_requested
    end
  end

  describe "#seek_ms!" do
    it "requires a parameter" do
      expect {
        subject.seek_ms!
      }.to raise_error ArgumentError, /wrong number of arguments/
    end

    it "should only accept an integer" do
      expect {
        subject.seek_ms!("beginning")
      }.to raise_error(/Must be an integer/)
    end

    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/seek?position_ms=123456&device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.seek_ms!(123_456)
      expect(stub).to have_been_requested
    end
  end

  describe "#repeat=" do
    it "should only accept :track, :context, or :off" do
      expect {
        subject.repeat = true
      }.to raise_error(/Must be :track, :context, or :off/)
    end

    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/repeat?state=context&device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.repeat = :context
      expect(stub).to have_been_requested
    end
  end

  describe "#repeat!" do
    it "requires a parameter" do
      expect {
        subject.repeat!
      }.to raise_error ArgumentError, /wrong number of arguments/
    end

    it "should only accept :track, :context, or :off" do
      expect {
        subject.repeat!(true)
      }.to raise_error(/Must be :track, :context, or :off/)
    end

    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/repeat?state=context&device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.repeat!(:context)
      expect(stub).to have_been_requested
    end
  end

  describe "#shuffle=" do
    it "should only accept true or false" do
      expect {
        subject.shuffle = 123_456
      }.to raise_error(/Must be true or false/)
    end

    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/shuffle?state=true&device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.shuffle = true
      expect(stub).to have_been_requested
    end
  end

  describe "#shuffle!" do
    it "requires a parameter" do
      expect {
        subject.shuffle!
      }.to raise_error ArgumentError, /wrong number of arguments/
    end

    it "should only accept true or false" do
      expect {
        subject.shuffle!("true")
      }.to raise_error(/Must be true or false/)
    end

    it "should make an api call" do
      stub = stub_request(:put, "https://api.spotify.com/v1/me/player/shuffle?state=true&device_id=#{raw_data[:id]}")
             .with(headers: {Authorization: "Bearer access_token"})

      subject.shuffle!(true)
      expect(stub).to have_been_requested
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
