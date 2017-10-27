# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Model do
  let(:payload) { {id: 123_456, username: "example", country_code: "GB"} }
  let(:sdk) { Spotify::SDK.new("access_token") }
  let(:connect_sdk) { Spotify::SDK::Connect.new(sdk) }

  context "good initialization" do
    it "should not raise an error" do
      expect {
        Spotify::SDK::Model.new(payload, connect_sdk)
      }.not_to raise_error
    end
  end

  context "bad initialization" do
    context "parameters count" do
      it "should raise an error if zero parameters are given" do
        expect {
          Spotify::SDK::Model.new
        }.to raise_error ArgumentError
      end

      it "should raise an error if only one parameter is given" do
        expect {
          Spotify::SDK::Model.new(payload)
        }.to raise_error ArgumentError
      end
    end

    context "first parameter" do
      it "should raise an error if not a hash" do
        expect {
          Spotify::SDK::Model.new("Hi world", connect_sdk)
        }.to raise_error Spotify::Errors::ModelPayloadExpectedToBeHashError
      end
    end

    context "second parameter" do
      it "should raise an error if not a hash" do
        expect {
          Spotify::SDK::Model.new(payload, "Hi world")
        }.to raise_error Spotify::Errors::ModelParentInvalidSDKBaseObjectError
      end
    end
  end
end
