# frozen_string_literal: true

module Spotify
  class SDK
    ##
    # For each SDK component, we have a Base class. We're using HTTParty.
    #
    class Base
      include HTTParty
      base_uri "api.spotify.com:443"

      ##
      # Initiate a Spotify SDK Base component.
      #
      # @example
      #   @sdk = Spotify::SDK.new("access_token")
      #   @auth = Spotify::SDK::Base.new(@sdk)
      #
      #   @sdk = Spotify::SDK.new("access_token_here")
      #   @sdk.to_hash # => { access_token: ..., expires_at: ... }
      #
      # @param [Spotify::SDK] sdk An instance of Spotify::SDK as a reference point.
      #
      def initialize(sdk)
        @sdk = sdk
        @options = {
          headers: {
            Authorization: "Bearer %s" % sdk.access_token
          }
        }
      end

      ##
      # Handle HTTParty responses.
      #
      # @example
      #   # Return the Hash from the JSON response.
      #   send_http_request(:get, "/v1/me/player/devices", @options)
      #
      #   # Return the raw HTTParty::Response object.
      #   send_http_request(:get, "/v1/me/player/devices", @options.merge(raw: true))
      #
      # @param [Hash,HTTParty::Response] response The response from the HTTP request.
      # @return
      #
      def send_http_request(method, endpoint, opts={}, &_block)
        sdk_opts = opts[:_sdk_opts].presence || {}
        opts_sdk = {raw: false, expect_nil: false}.merge(sdk_opts)
        response = self.class.send(method, endpoint, @options.merge(opts))
        response = response.parsed_response.try(:deep_symbolize_keys) if opts_sdk[:raw] == false
        response = true if opts_sdk[:expect_nil] == true && response.nil?
        response
      end

      attr_reader :sdk
    end
  end
end
