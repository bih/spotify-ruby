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
      #   handle_response self.class.get("/v1/me/player/devices", @options)
      #
      # @param [HTTParty::Response] response_obj The response object when a HTTParty request is made.
      # @return
      #
      def handle_response(response_obj, &_block)
        response = block_given? ? yield : response_obj
        response.parsed_response.deep_symbolize_keys
      end

      attr_reader :sdk
    end
  end
end
