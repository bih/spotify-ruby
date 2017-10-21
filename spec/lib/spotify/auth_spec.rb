# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::Auth do
  it "inherits from OAuth2::Client" do
    expect(Spotify::Auth < OAuth2::Client).to be_truthy
  end
end
