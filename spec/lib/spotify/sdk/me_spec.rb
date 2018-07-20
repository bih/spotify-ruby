# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Me do
  let(:session) { build(:session, access_token: "access_token") }
  subject { Spotify::SDK.new(session).me }

  describe "#info" do
    before(:each) do
      stub_spotify_api_request(fixture:  "get/v1/me/object",
                               method:   :get,
                               endpoint: "/v1/me")
    end

    it "should return a Spotify::SDK::Me::Info object" do
      expect(subject.info).to be_kind_of(Spotify::SDK::Me::Info)
    end

    it "should return the correct values" do
      expect(subject.info.to_h).to eq read_fixture("get/v1/me/object")
    end
  end
end
