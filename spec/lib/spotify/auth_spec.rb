# frozen_string_literal: true

require "spec_helper"
require "uri"
require "cgi"

RSpec.describe Spotify::Auth do
  it "inherits from OAuth2::Client" do
    expect(Spotify::Auth < OAuth2::Client).to be_truthy
  end

  it "has a SCOPES constant" do
    expect(Spotify::Auth::SCOPES).to be_present
    expect(Spotify::Auth::SCOPES).to be_a(Array)
    expect(Spotify::Auth::SCOPES).not_to be_empty
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

    context "authorize_url is valid" do
      let(:params) { CGI.parse(URI.parse(authorize_url).query) }
      let(:client_id) { params["client_id"][0] }
      let(:redirect_uri) { params["redirect_uri"][0] }
      let(:response_type) { params["response_type"][0] }
      let(:scope) { params["scope"][0].split(" ").map(&:to_sym) }

      context "default params" do
        let(:authorize_url) { subject.authorize_url }

        it "should include the correct base url" do
          expect(subject.authorize_url).to start_with "https://accounts.spotify.com/oauth/authorize"
        end

        it "should contain client_id with correct value" do
          expect(client_id).to eq "client id"
        end

        it "should contain redirect_uri with correct value" do
          expect(redirect_uri).to eq "https://localhost"
        end

        it "should contain response_type with correct value" do
          expect(response_type).to eq "code"
        end

        it "should contain all scopes by default" do
          expect(scope).to eq Spotify::Auth::SCOPES
        end
      end

      context "overriding client_id" do
        let(:authorize_url) { subject.authorize_url(client_id: "override client id") }

        it "should have new value" do
          expect(client_id).to eq "override client id"
        end
      end

      context "overriding redirect_uri" do
        let(:authorize_url) { subject.authorize_url(redirect_uri: "http://127.0.0.1") }

        it "should have new value" do
          expect(redirect_uri).to eq "http://127.0.0.1"
        end
      end

      context "overriding response_type" do
        let(:authorize_url) { subject.authorize_url(response_type: "override response type") }

        it "should have new value" do
          expect(response_type).to eq "override response type"
        end
      end

      context "overriding scope" do
        let(:authorize_url) { subject.authorize_url(scope: "scope1 scope2") }

        it "should have new value as an array with symbolized values" do
          expect(scope).to eq %i[scope1 scope2]
        end
      end
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
