# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Item do
  let(:raw_data) { read_fixture("get/v1/me/player/currently-playing/object")[:item] }
  subject { build(:item, raw_data) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  describe "#duration" do
    it "is an alias for #duration_ms" do
      expect(subject.duration).to eq subject.duration_ms
    end
  end

  describe "#explicit?" do
    it "is an alias for #explicit" do
      expect(subject.explicit?).to eq subject.explicit
    end
  end

  describe "#local?" do
    it "is an alias for #is_local" do
      expect(subject.local?).to eq subject.is_local
    end
  end

  describe "#playback?" do
    it "is an alias for #is_playback" do
      expect(subject.playback?).to eq subject.is_playback
    end
  end

  describe "#track?" do
    it "returns false if #type is not a track" do
      subject.type = "not_a_track"
      expect(subject.track?).to eq false
    end

    it "returns true if #type is a track" do
      subject.type = "track"
      expect(subject.track?).to eq true
    end
  end

  describe "#spotify_uri" do
    it "is an alias for #uri" do
      expect(subject.spotify_uri).to eq subject.uri
    end
  end

  describe "#spotify_url" do
    it "is an alias for #external_urls.spotify" do
      expect(subject.spotify_url).to eq subject.external_urls[:spotify]
    end
  end
end
