# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Me::Info do
  let(:raw_data) { read_fixture("get/v1/me/object") }
  let(:session) { build(:session, access_token: "access_token") }
  let(:me_sdk) { Spotify::SDK::Me.new(Spotify::SDK.new(session)) }
  subject { Spotify::SDK::Me::Info.new(raw_data, me_sdk) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  describe "#free?" do
    it "returns true if product equals free" do
      subject.product = "free"
      expect(subject.product).to eq "free"
      expect(subject.free?).to be true
    end

    it "returns false if product does not equal free" do
      subject.product = "premium"
      expect(subject.product).to eq "premium"
      expect(subject.free?).to be false
    end
  end

  describe "#premium?" do
    it "returns true if product equals premium" do
      subject.product = "premium"
      expect(subject.product).to eq "premium"
      expect(subject.premium?).to be true
    end

    it "returns false if product does not equal premium" do
      subject.product = "free"
      expect(subject.product).to eq "free"
      expect(subject.premium?).to be false
    end
  end

  describe "#birthdate" do
    it "returns a Date object with the correct value" do
      expect(subject.birthdate).to be_kind_of(Date)
      expect(subject.birthdate.to_s).to eq raw_data[:birthdate]
    end

    it "returns nil if the value is nil" do
      subject.birthdate = nil
      expect(subject.birthdate).to be_nil
    end
  end

  describe "#display_name?" do
    it "returns true if #display_name is not empty" do
      subject.display_name = "Sample Display Name"
      expect(subject.display_name?).to be true
    end

    it "returns false if #display_name is empty" do
      subject.display_name = nil
      expect(subject.display_name?).to be false
    end
  end

  describe "#images" do
    it "returns an array of Spotify::SDK::Image" do
      expect(subject.images).to be_kind_of(Array)
      expect(subject.images[0]).to be_kind_of(Spotify::SDK::Image)
      expect(subject.images[0].to_h).to eq raw_data[:images][0]
    end
  end

  describe "#followers" do
    it "is an alias for #to_h[:followers][:total]" do
      expect(subject.followers).not_to be_nil
      expect(subject.followers).to eq subject.to_h[:followers][:total]
    end
  end

  describe "#spotify_uri" do
    it "is an alias for #uri" do
      expect(subject.spotify_uri).not_to be_nil
      expect(subject.spotify_uri).to eq subject.uri
    end
  end

  describe "#spotify_url" do
    it "is an alias for #external_urls[:spotify]" do
      expect(subject.spotify_url).not_to be_nil
      expect(subject.spotify_url).to eq subject.external_urls[:spotify]
    end
  end
end
