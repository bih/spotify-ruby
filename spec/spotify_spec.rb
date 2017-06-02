# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify do
  it "has a version number" do
    expect(Spotify::VERSION).not_to be nil
  end
end
