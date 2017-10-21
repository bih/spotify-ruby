# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::Auth do
  it "inherits from OAuth2::Client" do
    expect(Spotify::Auth < OAuth2::Client).to be_truthy
  end

  context "during initialization" do
    subject {
      Spotify::Auth.new(client_id:     "client id",
                        client_secret: "client secret",
                        redirect_uri:  "https://localhost")
    }

    it "should set site with api.spotify.com" do
      expect(subject.site).to eq "https://api.spotify.com"
    end

    it "should set authorize_url to accounts.spotify.com/oauth/authorize" do
      expect(subject.options[:authorize_url]).to eq "https://accounts.spotify.com/oauth/authorize"
    end

    it "should not set token_url" do
      expect(subject.options[:token_url]).to eq "/oauth/token"
    end
  end

  context "bad initialization" do
    it "should raise error without a client_id" do
      expect {
        Spotify::Auth.new(client_secret: "client secret",
                          redirect_uri:  "https://localhost")
      }.to raise_error Spotify::Errors::AuthClientCredentialsError
    end

    it "should raise error without a client_secret" do
      expect {
        Spotify::Auth.new(client_id:    "client id",
                          redirect_uri: "https://localhost")
      }.to raise_error Spotify::Errors::AuthClientCredentialsError
    end

    it "should raise error without a redirect_uri" do
      expect {
        Spotify::Auth.new(client_id:     "client id",
                          client_secret: "client secret")
      }.to raise_error Spotify::Errors::AuthClientCredentialsError
    end
  end

  context "contains error handlers" do
    it "when auth credentials invalid" do
      expect(Spotify::Errors::AuthClientCredentialsError < StandardError).to be_truthy
    end
  end
end
