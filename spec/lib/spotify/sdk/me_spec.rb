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

  describe "#following?" do
    it "should raise an error if no arguments are provided" do
      expect {
        subject.following?
      }.to raise_error(ArgumentError)
    end

    it "should raise an error if first argument is not an Array" do
      expect {
        subject.following?("String")
      }.to raise_error(StandardError, /Must contain an array/)
    end

    it "should raise an error if first argument is an array with Integer" do
      expect {
        subject.following?([1, 2, 3, 4, 5])
      }.to raise_error(StandardError, /Must contain an array of String or Spotify::SDK::Artist/i)
    end

    it "should raise an error if second argument is not 'artist' or 'user'" do
      expect {
        subject.following?(["2CIMQHirSU0MQqyYHq0eOx"], :other)
      }.to raise_error(StandardError, /type must be either 'artist' or 'user'/i)
    end

    it "should raise an error if second argument is not 'artist' or 'user'" do
      stub_spotify_api_request(fixture:  "get/v1/me/following/contains/response",
                               method:   :get,
                               endpoint: "/v1/me/following/contains?type=artist&ids=2CIMQHirSU0MQqyYHq0eOx")

      expect(subject.following?(["2CIMQHirSU0MQqyYHq0eOx"])).to eq("2CIMQHirSU0MQqyYHq0eOx" => true)
    end

    it "should make only one API request if querying 50 or less artists" do
      artists = build_list(:artist, 50)
      artists_string = artists.map(&:id).join(",")

      expected_response = read_fixture("get/v1/me/following/contains/response").each_with_index.map {|response, index|
        {artists[index].id => response}
      }.reduce(:merge)

      stub = stub_spotify_api_request(fixture:  "get/v1/me/following/contains/response",
                                      method:   :get,
                                      endpoint: "/v1/me/following/contains?type=artist&ids=%s" % artists_string)

      expect(subject.following?(artists)).to eq expected_response
      expect(stub).to have_been_requested
    end

    it "should make only three API requests if querying 150 or less artists" do
      artists = build_list(:artist, 150)

      first_batch_string = artists[0...50].map(&:id).join(",")
      second_batch_string = artists[50...100].map(&:id).join(",")
      third_batch_string = artists[100...150].map(&:id).join(",")

      expected_response = (read_fixture("get/v1/me/following/contains/response") * 3).each_with_index.map {|response, index|
        {artists[index].id => response}
      }.reduce(:merge)

      first_stub = stub_spotify_api_request(fixture:  "get/v1/me/following/contains/response",
                                            method:   :get,
                                            endpoint: "/v1/me/following/contains?type=artist&ids=%s" % first_batch_string)

      second_stub = stub_spotify_api_request(fixture:  "get/v1/me/following/contains/response",
                                             method:   :get,
                                             endpoint: "/v1/me/following/contains?type=artist&ids=%s" % second_batch_string)

      third_stub = stub_spotify_api_request(fixture:  "get/v1/me/following/contains/response",
                                            method:   :get,
                                            endpoint: "/v1/me/following/contains?type=artist&ids=%s" % third_batch_string)

      expect(subject.following?(artists)).to eq expected_response

      expect(first_stub).to have_been_requested
      expect(second_stub).to have_been_requested
      expect(third_stub).to have_been_requested
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
