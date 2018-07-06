# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Album do
  let(:raw_data) { read_fixture("get/v1/me/player/currently-playing/object")[:item][:album] }
  subject { build(:album, raw_data) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  describe "#album?" do
    it "returns true if type equals album" do
      expect(subject.album?).not_to be_nil
      expect(subject.album?).to eq true
    end

    it "returns false if type does not equals album" do
      subject_copy = subject.dup
      subject_copy.type = "not_album"
      expect(subject_copy.album?).not_to be_nil
      expect(subject_copy.album?).to eq false
    end
  end

  describe "#images" do
    it "should return an array containing Spotify::SDK::Image instances" do
      expect(subject.images).to be_kind_of(Array)
      expect(subject.images[0]).to be_kind_of(Spotify::SDK::Image)
    end

    it "should return the images" do
      expect(subject.images[0].to_h).to eq subject.to_h[:images][0]
    end
  end

  describe "#artists" do
    it "should be an array of Spotify::SDK::Artist" do
      expect(subject.artists).not_to be_nil
      expect(subject.artists).to be_kind_of(Array)
      expect(subject.artists[0]).to be_kind_of(Spotify::SDK::Artist)
    end
  end

  describe "#artist" do
    it "should be the same as artists.first" do
      expect(subject.artist).not_to be_nil
      expect(subject.artist).to eq subject.artists.first
    end
  end

  describe "#spotify_uri" do
    it "is an alias for #uri" do
      expect(subject.spotify_uri).not_to be_nil
      expect(subject.spotify_uri).to eq subject.uri
    end
  end

  describe "#spotify_url" do
    it "is an alias for #external_urls.spotify" do
      expect(subject.spotify_url).not_to be_nil
      expect(subject.spotify_url).to eq subject.external_urls[:spotify]
    end
  end
end
