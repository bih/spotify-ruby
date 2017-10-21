# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::Auth do
  it "inherits from OAuth2::Client" do
    expect(Spotify::Auth < OAuth2::Client).to be_truthy
  end

  context "during initialization" do
    subject { Spotify::Auth.new("client id", "client secret") }

    it "it sets site with api.spotify.com" do
      expect(subject.site).to be "https://api.spotify.com"
    end

    it "it sets authorize_url to accounts.spotify.com/oauth/authorize" do
      expect(subject.options[:authorize_url]).to be "https://accounts.spotify.com/oauth/authorize"
    end

    it "it does not set token_url" do
      expect(subject.options[:token_url]).to be "/oauth/token"
    end
  end
end
