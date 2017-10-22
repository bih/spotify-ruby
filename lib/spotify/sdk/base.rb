# frozen_string_literal: true

module Spotify
  class SDK
    ##
    # For each SDK component, we have a Base class. We're using HTTParty.
    #
    class Base
      include HTTParty
      base_uri "api.spotify.com"

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
      end

      attr_reader :sdk
    end
  end
end
