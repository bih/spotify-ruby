# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Initialization::OAuthAccessToken do
  context "methods" do
    describe "#should_perform?" do
      it "should return true for an OAuth2::AccessToken instance" do
        access_token = OAuth2::AccessToken.new(oauth2_client, "access_token")
        initializer  = Spotify::SDK::Initialization::OAuthAccessToken.new(access_token)

        expect(initializer.should_perform?).to eq true
      end

      it "should return false for a String" do
        initializer = Spotify::SDK::Initialization::OAuthAccessToken.new("")

        expect(initializer.should_perform?).to eq false
      end
    end

    #   [
    #     OAuth2::AccessToken.new(client, SAMPLE_TOKEN, {}),
    #     OAuth2::AccessToken.new(client, SAMPLE_TOKEN, { expires_in: 1234567890 }),
    #     OAuth2::AccessToken.new(client, SAMPLE_TOKEN, { expires_in: 1234567890, refresh_token: SAMPLE_TOKEN })
    #   ]
    # end

    describe "#perform" do
      context "with only access token" do
        it "should return the right output" do
          access_token = OAuth2::AccessToken.new(oauth2_client, "access_token")
          initializer  = Spotify::SDK::Initialization::OAuthAccessToken.new(access_token)

          expect(initializer.perform).to eq(access_token:  "access_token",
                                            expires_in:    nil,
                                            refresh_token: nil)
        end
      end

      context "with access token and expires in" do
        it "should return the right output" do
          access_token = OAuth2::AccessToken.new(oauth2_client, "access_token", expires_in: 123_456)
          initializer  = Spotify::SDK::Initialization::OAuthAccessToken.new(access_token)

          expect(initializer.perform).to eq(access_token:  "access_token",
                                            expires_in:    123_456,
                                            refresh_token: nil)
        end
      end

      context "with access token, expires in and refresh token" do
        it "should return the right output" do
          access_token = OAuth2::AccessToken.new(oauth2_client, "access_token", expires_in: 123_456, refresh_token: "refresh_token")
          initializer  = Spotify::SDK::Initialization::OAuthAccessToken.new(access_token)

          expect(initializer.perform).to eq(access_token:  "access_token",
                                            expires_in:    123_456,
                                            refresh_token: "refresh_token")
        end
      end
    end
  end

  private

  def oauth2_client
    Spotify::Auth.new(client_id:     "12345676",
                      client_secret: "12345678",
                      redirect_uri:  "http://localhost/callback")
  end
end
