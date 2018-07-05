# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Image do
  let(:raw_data) { read_fixture("get/v1/artist/full-object")[:images][0] }
  subject { build(:image, raw_data) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  describe "#id" do
    it "returns the ID from #url" do
      expect(subject.id).to eq "84282c28d851a700132356381fcfbadc67ff498b"
    end
  end

  describe "#spotify_uri" do
    it "returns a properly formatted URL" do
      expect(subject.spotify_uri).to eq "spotify:image:84282c28d851a700132356381fcfbadc67ff498b"
    end
  end

  describe "#spotify_url" do
    it "is an alias for #url" do
      expect(subject.spotify_uri).not_to be_nil
      expect(subject.spotify_url).to eq subject.url
    end
  end
end
