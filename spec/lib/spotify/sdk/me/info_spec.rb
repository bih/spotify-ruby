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
end
