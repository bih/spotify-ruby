# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK do
  let(:session) { build(:session) }
  subject { Spotify::SDK.new(session) }

  describe "#session" do
    let(:accounts) { build(:accounts) }
    let(:session) { build(:session, accounts: accounts) }

    it "should return an instance of Spotify::Accounts::Session" do
      expect(session).to be_kind_of(Spotify::Accounts::Session)
    end

    describe "#access_token" do
      it "should return the correct value" do
        expect(subject.session.access_token).to eq session.access_token
      end
    end

    describe "#expires_in" do
      it "should return the correct value" do
        expect(subject.session.expires_in).to eq session.expires_in
      end
    end

    describe "#expires_at" do
      it "should return the correct value" do
        expect(subject.session.expires_at).to eq session.expires_at
      end
    end

    describe "#refresh_token" do
      it "should return the correct value" do
        expect(subject.session.refresh_token).to eq session.refresh_token
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
  end

  context "Mounted SDK Components" do
    describe "#connect" do
      it "should return an instance of Spotify::SDK:Connect" do
        expect(subject.connect).to be_kind_of(Spotify::SDK::Connect)
        expect(subject.connect.parent).to eq subject
      end
    end
  end
end
