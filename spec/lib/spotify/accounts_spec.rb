# frozen_string_literal: true

require "spec_helper"
require "uri"
require "cgi"

RSpec.describe Spotify::Accounts do
  it "has a SCOPES constant" do
    expect(Spotify::Accounts::SCOPES).to be_present.and be_a(Array)
  end

  shared_context "correctly stores client information" do
    it "should set client_id" do
      expect(subject.client_id).to eq "client id"
    end

    it "should set client_secret" do
      expect(subject.client_secret).to eq "client secret"
    end

    it "should set redirect_uri" do
      expect(subject.redirect_uri).to eq "https://localhost"
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
          expect(scope).to eq Spotify::Accounts::SCOPES
        end
      end

      context "overriding client_id" do
        let(:authorize_url) { subject.authorize_url(client_id: "override client id") }

        it "should have new value" do
          expect(client_id).to eq "override client id"
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

      context "overriding redirect_uri" do
        let(:authorize_url) { subject.authorize_url(redirect_uri: "http://127.0.0.1") }

        it "should not have new value" do
          expect(redirect_uri).to eq "http://127.0.0.1"
        end
      end
    end
  end

  context "on initialization" do
    subject do
      Spotify::Accounts.new(client_id:     "client id",
                            client_secret: "client secret",
                            redirect_uri:  "https://localhost")
    end

    include_context "correctly stores client information"
  end

  context "on initialization with environment variables" do
    subject do
      ClimateControl.modify(SPOTIFY_CLIENT_ID:     "client id",
                            SPOTIFY_CLIENT_SECRET: "client secret",
                            SPOTIFY_REDIRECT_URI:  "https://localhost") do
        Spotify::Accounts.new
      end
    end

    include_context "correctly stores client information"
  end

  context "post initialization" do
    subject do
      accounts = Spotify::Accounts.new
      accounts.client_id = "client id"
      accounts.client_secret = "client secret"
      accounts.redirect_uri = "https://localhost"
      accounts
    end

    include_context "correctly stores client information"
  end

  context "bad configuration" do
    it "authorize_url should raise error without a client_id" do
      accounts = Spotify::Accounts.new(client_secret: "client secret",
                                       redirect_uri:  "https://localhost")
      expect { accounts.authorize_url }.to raise_error(RuntimeError, "Missing client id")
    end

    it "authorize_url should raise error without a client_secret" do
      accounts = Spotify::Accounts.new(client_id:    "client id",
                                       redirect_uri: "https://localhost")
      expect { accounts.authorize_url }.to raise_error(RuntimeError, "Missing client secret")
    end

    it "authorize_url should raise error without a redirect_uri" do
      accounts = Spotify::Accounts.new(client_id:     "client id",
                                       client_secret: "client secret")
      expect { accounts.authorize_url }.to raise_error(RuntimeError, "Missing redirect uri")
    end
  end
end
