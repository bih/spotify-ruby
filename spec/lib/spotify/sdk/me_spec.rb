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

  describe "#following" do
    it "should make one request if first request is empty" do
      stub = stub_spotify_api_request(fixture:  "get/v1/me/following/empty-response",
                                      method:   :get,
                                      endpoint: "/v1/me/following?type=artist&limit=50")

      subject.following
      expect(stub).to have_been_requested.times(1)
    end

    it "should make one request if first request next is null" do
      stub = stub_spotify_api_request(fixture:  "get/v1/me/following/valid-response-without-next",
                                      method:   :get,
                                      endpoint: "/v1/me/following?type=artist&limit=50")

      subject.following
      expect(stub).to have_been_requested.times(1)
    end

    it "should make two requests if second request next is null" do
      first_stub = stub_spotify_api_request(fixture:  "get/v1/me/following/valid-response-with-next",
                                            method:   :get,
                                            endpoint: "/v1/me/following?type=artist&limit=50")

      second_stub = stub_spotify_api_request(fixture:  "get/v1/me/following/valid-response-without-next",
                                             method:   :get,
                                             endpoint: "/v1/me/following?after=1uNFoZAHBGtllmzznpCI3s&limit=50&type=artist")

      subject.following
      expect(first_stub).to have_been_requested.times(1)
      expect(second_stub).to have_been_requested.times(1)
    end

    it "should return N artists if valid response returns N artists" do
      stub_spotify_api_request(fixture:  "get/v1/me/following/valid-response-with-next",
                               method:   :get,
                               endpoint: "/v1/me/following?type=artist&limit=50")

      stub_spotify_api_request(fixture:  "get/v1/me/following/valid-response-without-next",
                               method:   :get,
                               endpoint: "/v1/me/following?after=1uNFoZAHBGtllmzznpCI3s&limit=50&type=artist")

      expect(subject.following).to be_kind_of(Array).and have(18).items
      expect(subject.following[0]).to be_kind_of(Spotify::SDK::Artist)
    end
    #
    it "should return an empty array if empty response" do
      stub_spotify_api_request(fixture:  "get/v1/me/following/empty-response",
                               method:   :get,
                               endpoint: "/v1/me/following?type=artist&limit=50")

      expect(subject.following).to be_kind_of(Array).and have(0).items
    end
  end
end
