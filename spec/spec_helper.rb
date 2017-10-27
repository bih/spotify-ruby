# frozen_string_literal: true

require "bundler/setup"
require "spotify"
require "coveralls"
require "webmock/rspec"

# Code coverage.
Coveralls.wear!

# Capture all API calls.
WebMock.disable_net_connect!(allow_localhost: true)

module Helpers
  ##
  # Mock Spotify API requests.
  #
  def stub_spotify_api_request(method, endpoint)
    StubSpotifyAPIRequestHelper.new(method, endpoint).perform
  end

  class StubSpotifyAPIRequestHelper < OpenStruct
    REQUEST_HEADERS = {Authorization: "Bearer access_token"}.freeze
    RESPONSE_HEADERS = {"Content-Type": "application/json; charset=utf-8"}.freeze

    def initialize(method, endpoint)
      @method   = method
      @endpoint = endpoint
    end

    def perform
      WebMock::API.stub_request(@method, "https://api.spotify.com%s" % @endpoint)
                  .with(headers: REQUEST_HEADERS)
                  .to_return(status: 200, body: File.read(fixture_path), headers: RESPONSE_HEADERS)
    end

    def fixture_filename
      "%s%s.json" % [@method.to_s, @endpoint.tr("/", "-")]
    end

    def fixture_path
      File.expand_path("../", __FILE__) + "/support/fixtures/%s" % fixture_filename
    end
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Include custom helper methods.
  config.include Helpers

  # Use expect syntax.
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
