# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Base do
  let(:session) { build(:session) }
  let(:sdk) { Spotify::SDK.new(session) }
  subject { Spotify::SDK::Base.new(sdk) }

  it "inherits from HTTParty" do
    expect(Spotify::SDK::Base < HTTParty).to be_truthy
  end

  context "good initialization" do
    it "sets @sdk to initialized value" do
      expect(subject.parent).to eq sdk
    end
  end

  describe "@options" do
    let(:options) { subject.instance_variable_get(:@options) }

    context "Headers" do
      describe "Authorization" do
        it "should contain the correct value" do
          expect(options[:headers][:Authorization]).to eq "Bearer %s" % session.access_token
        end
      end
    end
  end

  describe "#sdk=" do
    it "should not be defined" do
      expect(subject).not_to respond_to(:sdk=)
    end
  end
end
