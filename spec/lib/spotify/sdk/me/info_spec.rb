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
end
