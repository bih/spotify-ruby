# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Base do
  it "inherits from HTTParty" do
    expect(Spotify::SDK::Base < HTTParty).to be_truthy
  end
end
