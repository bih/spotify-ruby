# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK do
  subject do
    Spotify::SDK.new(access_token:  "insert_access_token",
                     expires_in:    3_000_000,
                     refresh_token: "insert_refresh_token")
  end

  describe "#access_token" do
    it "should return the correct value" do
      expect(subject.access_token).to eq "insert_access_token"
    end
  end

  describe "#expires_in" do
    it "should return the correct value" do
      expect(subject.expires_in).to eq 3_000_000
    end
  end

  describe "#refresh_token" do
    it "should return the correct value" do
      expect(subject.refresh_token).to eq "insert_refresh_token"
    end
  end

  describe "#access_token=" do
    it "should not be defined" do
      expect(subject).not_to respond_to(:access_token=)
    end
  end

  describe "#expires_in=" do
    it "should not be defined" do
      expect(subject).not_to respond_to(:expires_in=)
    end
  end

  describe "#refresh_token=" do
    it "should not be defined" do
      expect(subject).not_to respond_to(:refresh_token=)
    end
  end

  describe "#oauth2_access_token" do
    let(:oauth2_client) do
      Spotify::Auth.new(client_id:     "client id",
                        client_secret: "client secret",
                        redirect_uri:  "redirect uri")
    end
    let(:oauth2_access_token) { subject.oauth2_access_token(oauth2_client) }

    it "should return an instance of OAuth2::AccessToken" do
      expect(oauth2_access_token).to be_kind_of(OAuth2::AccessToken)
    end

    context "OAuth2::AccessToken" do
      describe "#token" do
        it "should return the correct value" do
          expect(oauth2_access_token.token).to eq "insert_access_token"
        end
      end

      describe "#expires_in" do
        it "should return the correct value" do
          expect(oauth2_access_token.expires_in).to eq 3_000_000
        end
      end

      describe "#refresh_token" do
        it "should return the correct value" do
          expect(oauth2_access_token.refresh_token).to eq "insert_refresh_token"
        end
      end
    end
  end

  describe "#to_hash" do
    it "should return the correct value" do
      expect(subject.to_hash).to eq(access_token:  "insert_access_token",
                                    expires_in:    3_000_000,
                                    refresh_token: "insert_refresh_token")
    end
  end

  context "Mounted SDK Components" do
    describe "#connect" do
      it "should return an instance of Spotify::SDK:Connect" do
        expect(subject.connect).to be_kind_of(Spotify::SDK::Connect)
        expect(subject.connect.sdk).to eq subject
      end
    end
  end
end
