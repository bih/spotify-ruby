# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Item do
  let(:raw_data) { read_fixture("get/v1/item/object") }
  subject { build(:item, raw_data) }

  describe "#to_h" do
    it "returns the correct value" do
      expect(subject.to_h).to eq raw_data
    end
  end
end
