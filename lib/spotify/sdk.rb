# frozen_string_literal: true

require "spotify/sdk/initialization"

module Spotify
  ##
  # Spotify::SDK contains the complete Ruby DSL to interact with the Spotify Platform.
  #
  class SDK
    ##
    # Initialize the Spotify SDK object.
    #
    # @example
    #   @auth = Spotify::SDK.new("access_token_here")
    #
    #   @auth = Spotify::SDK.new({
    #     access_token: "access_token_here",
    #     expires_at: "",
    #     refresh_token: "http://localhost"
    #   })
    #
    #   @auth = Spotify::SDK
    #
    # @param [Hash] config OAuth configuration containing the Client ID, secret and redirect URL.
    #
    # @see https://developer.spotify.com/my-applications/
    #
    def initialize(obj)
      @payload = Spotify::SDK::Initialization.detect(obj)
      @access_token  = @payload[:access_token]
      @expires_at    = @payload[:expires_at]
      @refresh_token = @payload[:refresh_token]
    end

    def oauth2_access_token(auth)
      OAuth2::AccessToken.new(auth, @access_token, expires_at:    @expires_at,
                                                   refresh_token: @refresh_token)
    end

    def to_hash
      @payload
    end

    attr_reader :access_token, :expires_at, :refresh_token
  end

  class Errors
  end
end
