# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Image do
  let(:raw_data) { read_fixture("get/v1/image/object") }
  subject { build(:image, raw_data) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  describe "#id" do
    it "returns the ID from #url" do
      expect(subject.id).to eq "c2c45f862fdecde97ea2aabf8a8bd70299c63a1e"
    end
  end

  describe "#spotify_uri" do
    it "returns a properly formatted URL" do
      expect(subject.spotify_uri).to eq "spotify:image:c2c45f862fdecde97ea2aabf8a8bd70299c63a1e"
    end
  end

  describe "#spotify_url" do
    it "is an alias for #url" do
      expect(subject.spotify_url).to eq subject.url
    end
  end
end
