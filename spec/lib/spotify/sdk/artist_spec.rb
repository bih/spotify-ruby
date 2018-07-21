# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Artist do
  let(:session) { build(:session, access_token: "access_token") }

  context "Short Response" do
    let(:raw_data) { read_fixture("get/v1/artist/simple-object") }
    let(:connect_sdk) { Spotify::SDK::Connect.new(Spotify::SDK.new(session)) }
    subject { Spotify::SDK::Artist.new(raw_data, connect_sdk) }

    describe "#to_h" do
      it "returns the correct value" do
        expect(subject.to_h).to eq raw_data
      end
    end

    describe "#full_information?" do
      it "returns false" do
        expect(subject.full_information?).to eq false
      end
    end

    describe "#retrieve_full_information!" do
      let(:artist_response) { read_fixture("get/v1/artist/full-object") }
      before(:each) do
        stub_spotify_api_request(fixture:  "get/v1/artist/full-object",
                                 method:   :get,
                                 endpoint: "/v1/artists/%s" % raw_data[:id])
      end

      it "after calling, #full_information? should return true" do
        expect {
          subject.retrieve_full_information!
        }.to change {
          subject.full_information?
        }.from(false).to(true)
      end
    end

    describe "#follow!" do
      it "should make an api call" do
        stub = stub_request(:put, "https://api.spotify.com/v1/me/following?type=artist&ids=%s" % raw_data[:id])
               .with(headers: {Authorization: "Bearer access_token"})

        subject.follow!

        expect(stub).to have_been_requested.times(1)
      end
    end

    describe "#unfollow!" do
      it "should make an api call" do
        stub = stub_request(:delete, "https://api.spotify.com/v1/me/following?type=artist&ids=%s" % raw_data[:id])
               .with(headers: {Authorization: "Bearer access_token"})

        subject.unfollow!

        expect(stub).to have_been_requested.times(1)
      end
    end

    describe "#images" do
      let(:images) { read_fixture("get/v1/artist/full-object")[:images] }
      before(:each) do
        stub_spotify_api_request(fixture:  "get/v1/artist/full-object",
                                 method:   :get,
                                 endpoint: "/v1/artists/%s" % raw_data[:id])
      end

      it "should invoke #retrieve_full_information" do
        expect {
          subject.images
        }.to change {
          subject.full_information?
        }.from(false).to(true)
      end

      it "should return an array containing Spotify::SDK::Image instances" do
        expect(subject.images).to be_kind_of(Array)
        expect(subject.images[0]).to be_kind_of(Spotify::SDK::Image)
      end

      it "should return the images" do
        expect(subject.images.map(&:to_h)).to eq images
      end
    end

    describe "#spotify_url" do
      it "returns spotify from the external_urls column" do
        expect(subject.spotify_url).not_to be_nil
        expect(subject.spotify_url).to eq subject.external_urls[:spotify]
      end
    end

    describe "#spotify_uri" do
      it "is an alias for #uri" do
        expect(subject.spotify_uri).not_to be_nil
        expect(subject.spotify_uri).to eq subject.uri
      end
    end
  end

  context "Long Response" do
    let(:raw_data) { read_fixture("get/v1/artist/full-object") }
    let(:connect_sdk) { Spotify::SDK::Connect.new(Spotify::SDK.new(session)) }
    subject { Spotify::SDK::Artist.new(raw_data, connect_sdk) }

    describe "#to_h" do
      it "returns the correct value" do
        expect(subject.to_h).to eq raw_data
      end
    end

    describe "#full_information?" do
      it "returns true" do
        expect(subject.full_information?).to eq true
      end
    end

    describe "#retrieve_full_information!" do
      it "should not change #full_information?" do
        expect {
          subject.retrieve_full_information!
        }.not_to(change {
          subject.full_information?
        })
      end
    end

    describe "#images" do
      let(:images) { read_fixture("get/v1/artist/full-object")[:images] }

      it "should not invoke #retrieve_full_information" do
        expect {
          subject.images
        }.not_to(change {
          subject.full_information?
        })
      end

      it "should return an array containing Spotify::SDK::Image instances" do
        expect(subject.images).to be_kind_of(Array)
        expect(subject.images[0]).to be_kind_of(Spotify::SDK::Image)
      end

      it "should return the images" do
        expect(subject.images.map(&:to_h)).to eq images
      end
    end

    describe "#spotify_url" do
      it "returns spotify from the external_urls column" do
        expect(subject.spotify_url).not_to be_nil
        expect(subject.spotify_url).to eq raw_data[:external_urls][:spotify]
      end
    end

    describe "#spotify_uri" do
      it "is an alias for #uri" do
        expect(subject.spotify_uri).not_to be_nil
        expect(subject.spotify_uri).to eq subject.uri
      end
    end

    describe "#followers" do
      it "is an alias for #followers[:total]" do
        expect(subject.followers).not_to be_nil
        expect(subject.followers).to eq raw_data[:followers][:total]
      end
    end

    describe "#images" do
      it "returns the correct value" do
        expect(subject.images).not_to be_nil
        expect(subject.images.map(&:to_h)).to eq raw_data[:images]
      end
    end
  end
end
