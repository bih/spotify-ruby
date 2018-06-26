# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Artist do
  let(:session) { build(:session, access_token: "access_token") }

  context "Short Response" do
    let(:raw_data) { read_fixture("get/v1/artist/short-response") }
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
      let(:images) { read_fixture("get/v1/artist/long-response")[:images] }
      before(:each) do
        stub_spotify_api_request(fixture:  "get/v1/artist/long-response",
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

      it "after calling, #images should not be nil" do
        expect {
          subject.retrieve_full_information!
        }.to change {
          subject.images
        }.from(nil).to(images)
      end
    end

    describe "#spotify_url" do
      it "returns spotify from the external_urls column" do
        expect(subject.spotify_url).to eq subject.external_urls[:spotify]
      end
    end

    describe "#spotify_uri" do
      it "is an alias for #uri" do
        expect(subject.spotify_uri).to eq subject.uri
      end
    end
  end

  context "Long Response" do
    let(:raw_data) { read_fixture("get/v1/artist/long-response") }
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

    describe "#spotify_url" do
      it "returns spotify from the external_urls column" do
        expect(subject.spotify_url).to eq raw_data[:external_urls][:spotify]
      end
    end

    describe "#spotify_uri" do
      it "is an alias for #uri" do
        expect(subject.spotify_uri).to eq subject.uri
      end
    end

    describe "#followers" do
      it "is an alias for #followers[:total]" do
        expect(subject.followers).to eq raw_data[:followers][:total]
      end
    end

    describe "#images" do
      it "returns the correct value" do
        expect(subject.images).to eq raw_data[:images]
      end
    end
  end
end
