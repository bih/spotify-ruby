require "spec_helper"

RSpec.describe Spotify do
  it "has a version number" do
    expect(Spotify::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
