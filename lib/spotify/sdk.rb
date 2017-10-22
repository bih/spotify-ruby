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
    #   # Example 1: Load it in from an access token value.
    #   @sdk = Spotify::SDK.new("access_token_here")
    #
    #   # Example 2: Load it in with values from your database.
    #   @sdk = Spotify::SDK.new({
    #     access_token: "access_token_here",
    #     expires_at: 3_000_000,
    #     refresh_token: "refresh_token_here"
    #   })
    #
    #   # Example 4: Load it in from an OAuth2::AccessToken object.
    #   @sdk = Spotify::SDK.new(@auth.auth_code.get_token("auth code"))
    #
    #   # Example 5: Load it from a query string or a fully qualified URL.
    #   @sdk = Spotify::SDK.new("https://localhost:8080/#token=...&expires_at=...")
    #   @sdk = Spotify::SDK.new("token=...&expires_at=...")
    #
    # @param [String, Hash, OAuth2::AccessToken] obj Any supported object which contains an access token. See examples.
    #
    def initialize(obj)
      @payload = Spotify::SDK::Initialization.detect(obj)
      @access_token  = @payload[:access_token]
      @expires_at    = @payload[:expires_at]
      @refresh_token = @payload[:refresh_token]
    end

    ##
    # Helper method to a fully qualified OAuth2::AccessToken instance.
    #
    # @example
    #   @auth = Spotify::Auth.new({
    #     client_id: "[client id goes here]",
    #     client_secret: "[client secret goes here]",
    #     redirect_uri: "http://localhost"
    #   })
    #
    #   @sdk = Spotify::SDK.new("access_token_here")
    #   @sdk.oauth2_access_token(@auth) # => #<OAuth2::AccessToken:...>
    #
    # @param [Spotify::Auth] client An instance of Spotify::Auth. See example.
    # @return [OAuth2::AccessToken] An fully qualified instance of OAuth2::AccessToken.
    #
    def oauth2_access_token(client)
      OAuth2::AccessToken.new(client, @access_token, expires_at:    @expires_at,
                                                     refresh_token: @refresh_token)
    end

    ##
    # Obtain a hash containing all of the user's authorization details.
    #
    # @example
    #   @auth = Spotify::Auth.new({
    #     client_id: "[client id goes here]",
    #     client_secret: "[client secret goes here]",
    #     redirect_uri: "http://localhost"
    #   })
    #
    #   @sdk = Spotify::SDK.new("access_token_here")
    #   @sdk.to_hash # => { access_token: ..., expires_at: ... }
    #
    # @return [Hash] Containing access_token, expires_at and refresh_token
    #
    def to_hash
      @payload.with_indifferent_access.symbolize_keys
    end

    attr_reader :access_token, :expires_at, :refresh_token
  end
end
