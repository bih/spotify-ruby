# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Base do
  let(:sdk) { Spotify::SDK.new("access_token") }
  subject { Spotify::SDK::Base.new(sdk) }

  it "inherits from HTTParty" do
    expect(Spotify::SDK::Base < HTTParty).to be_truthy
  end

  context "good initialization" do
    it "sets @sdk to initialized value" do
      expect(subject.sdk).to eq sdk
    end
  end

  describe "#sdk=" do
    it "should not be defined" do
      expect(subject).not_to respond_to(:sdk=)
    end
  end
end
