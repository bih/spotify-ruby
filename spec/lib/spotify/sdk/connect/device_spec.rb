# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Connect::Device do
  let(:raw_data) do
    {
      id:             "941223d904f006c4d998598272d43d94",
      is_active:      true,
      is_restricted:  false,
      name:           "Bilawal's Macbook Pro",
      type:           "Computer",
      volume_percent: 100
    }
  end
  subject { Spotify::SDK::Connect::Device.new(raw_data) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end

  context "Method Missing" do
    it "connects method calls to raw_data" do
      raw_data.each do |key, value|
        expect(subject.send(key)).to eq value
      end
    end
  end
end
