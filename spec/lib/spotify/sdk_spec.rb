# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK do
  subject do
    Spotify::SDK.new(access_token:  "insert_access_token",
                     expires_at:    3_000_000,
                     refresh_token: "insert_refresh_token")
  end

  describe "#access_token" do
    it "should return the correct value" do
      expect(subject.access_token).to eq "insert_access_token"
    end
  end

  describe "#expires_at" do
    it "should return the correct value" do
      expect(subject.expires_at).to eq 3_000_000
    end
  end

  describe "#refresh_token" do
    it "should return the correct value" do
      expect(subject.refresh_token).to eq "insert_refresh_token"
    end
  end

  describe "#access_token=" do
    it "should not be defined" do
      expect(subject).not_to respond_to(:access_token=)
    end
  end

  describe "#expires_at=" do
    it "should not be defined" do
      expect(subject).not_to respond_to(:expires_at=)
    end
  end

  describe "#refresh_token=" do
    it "should not be defined" do
      expect(subject).not_to respond_to(:refresh_token=)
    end
  end
end
