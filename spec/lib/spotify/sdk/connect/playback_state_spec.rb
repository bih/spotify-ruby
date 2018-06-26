# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Connect::PlaybackState do
  let(:raw_data) { read_fixture("get/v1/me/player/currently-playing/valid-response") }
  let(:session) { build(:session, access_token: "access_token") }
  let(:connect_sdk) { Spotify::SDK::Connect.new(Spotify::SDK.new(session)) }
  subject { Spotify::SDK::Connect::PlaybackState.new(raw_data, connect_sdk) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  describe "#device" do
    it "returns an instance of Spotify::SDK::Connect::Device" do
      expect(subject.device).to be_kind_of Spotify::SDK::Connect::Device
    end

    it "returns the correct value" do
      expect(subject.device.to_h).to eq raw_data[:device]
    end
  end

  describe "#shuffling?" do
    it "is an alias for #shuffle_state" do
      expect(subject.shuffling?).to eq subject.shuffle_state
    end
  end

  describe "#repeat_mode" do
    it "is a symbolized alias for #shuffle_state" do
      expect(subject.repeat_mode).to eq subject.repeat_state.to_sym
    end
  end

  describe "#time" do
    it "returns a Time object based on #timestamp" do
      expect(subject.time).to eq Time.at(subject.timestamp / 1000)
    end
  end

  describe "#artists" do
    it "returns an Array of Spotify::SDK::Artist instances" do
      expect(subject.artists).to be_kind_of(Array)
      expect(subject.artists[0]).to be_kind_of(Spotify::SDK::Artist)
    end
  end

  describe "#artist" do
    it "returns the first item from #artists" do
      expect(subject.artist).to eq subject.artists[0]
    end
  end
end
