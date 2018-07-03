# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Image do
  let(:raw_data) { read_fixture("get/v1/image/object") }
  subject { build(:image) }

  describe "#to_h" do
    it "returns the correct value" do
      puts subject.inspect
      # expect(subject.to_h).to eq raw_data
    end
  end
end
