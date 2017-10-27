# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Initialization::Base do
  context "methods" do
    subject { Spotify::SDK::Initialization::Base.new("") }

    describe "#subject" do
      it "should be readable" do
        expect(subject).to respond_to(:subject)
      end

      it "should not be writable" do
        expect(subject).not_to respond_to(:subject=)
      end
    end

    describe "#should_perform?" do
      it "should be equal to false" do
        expect(subject.should_perform?).to eq false
      end
    end

    describe "#perform" do
      it "should return a hash with nils" do
        expect(subject.perform).to eq(access_token:  nil,
                                      expires_in:    nil,
                                      refresh_token: nil)
      end
    end
  end

  context "good initialization" do
    it "should accept a single parameter with a string" do
      expect {
        Spotify::SDK::Initialization::Base.new("")
      }.not_to raise_error
    end

    it "should accept a single parameter with a hash" do
      expect {
        Spotify::SDK::Initialization::Base.new({})
      }.not_to raise_error
    end

    it "should accept a single parameter with a object" do
      expect {
        Spotify::SDK::Initialization::Base.new(Object.new)
      }.not_to raise_error
    end
  end

  context "bad initialization" do
    it "should raise an error if no argument is passed" do
      expect {
        Spotify::SDK::Initialization::Base.new
      }.to raise_error ArgumentError
    end
  end
end
