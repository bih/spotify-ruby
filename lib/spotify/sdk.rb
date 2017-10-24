# frozen_string_literal: true

require "spotify/sdk/initialization"
require "spotify/sdk/initialization/base"
require "spotify/sdk/initialization/oauth_access_token"
require "spotify/sdk/initialization/plain_string"
require "spotify/sdk/initialization/query_hash"
require "spotify/sdk/initialization/query_string"
require "spotify/sdk/initialization/url_string"
require "spotify/sdk/base"
require "spotify/sdk/connect"
require "spotify/sdk/connect/device"

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
    #     expires_in: 3_000_000,
    #     refresh_token: "refresh_token_here"
    #   })
    #
    #   # Example 4: Load it in from an OAuth2::AccessToken object.
    #   @sdk = Spotify::SDK.new(@auth.auth_code.get_token("auth code"))
    #
    #   # Example 5: Load it from a query string or a fully qualified URL.
    #   @sdk = Spotify::SDK.new("https://localhost:8080/#token=...&expires_in=...")
    #   @sdk = Spotify::SDK.new("token=...&expires_in=...")
    #
    # @param [String, Hash, OAuth2::AccessToken] obj Any supported object which contains an access token. See examples.
    #
    def initialize(obj)
      @payload = Spotify::SDK::Initialization.detect(obj)
      @access_token  = @payload[:access_token]
      @expires_in    = @payload[:expires_in]
      @refresh_token = @payload[:refresh_token]

      mount_sdk_components
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
      OAuth2::AccessToken.new(client, @access_token, expires_in:    @expires_in,
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
    #   @sdk.to_hash # => { access_token: ..., expires_in: ... }
    #
    # @return [Hash] Containing access_token, expires_in and refresh_token
    #
    def to_hash
      @payload.with_indifferent_access.symbolize_keys
    end

    attr_reader :access_token, :expires_in, :refresh_token
    attr_reader :connect

    private

    ##
    # This is where we mount all SDK components to the SDK object.
    # When mounting a new component, you'll need to do the following:
    # - Be sure to add a `attr_reader` for it. Developers can't access it otherwise.
    # - Add a test for it in spec/lib/spotify/sdk_spec.rb (see how we did it for others)
    #
    # @return [nil]
    #
    def mount_sdk_components
      @connect = Spotify::SDK::Connect.new(self)
    end
  end
end
