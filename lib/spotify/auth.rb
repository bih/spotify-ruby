# frozen_string_literal: true

require "oauth2"

module Spotify
  ##
  # Spotify::Auth inherits from OAuth2::Client based on the "oauth-2" gem.
  #
  class Auth < OAuth2::Client
    ##
    # An entire list of Spotify's OAuth scopes. Stored
    # in the form of a symbolized array.
    # Example: `[:scope1, :scope2]`
    #
    # @see https://developer.spotify.com/web-api/using-scopes/
    #
    # Last updated: 21 October 2017
    #
    SCOPES = %i[
      playlist-read-private playlist-read-collaborative
      playlist-modify-public playlist-modify-private
      ugc-image-upload user-follow-modify user-follow-read
      user-library-read user-library-modify user-read-private
      user-read-birthdate user-read-email user-top-read
      user-read-playback-state user-modify-playback-state
      user-read-currently-playing user-read-recently-played
      streaming
    ].freeze

    ##
    # Error-related translations we're using.
    #
    OAUTH_I18N = {
      must_be_hash: "Must be a Hash. Example: Spotify::Auth.new({ client_id: '', ... })",
      require_attr: "Expecting a '%s' key. You can obtain from https://developer.spotify.com"
    }.freeze

    ##
    # Initialize the Spotify Auth object.
    #
    # @example
    #
    #   @auth = Spotify::Auth.new({
    #     client_id: "[client id goes here]",
    #     client_secret: "[client secret goes here]",
    #     redirect_uri: "http://localhost"
    #   })
    #
    # @param [Hash] config OAuth configuration containing the Client ID, secret and redirect URL.
    # The redirect URL can be overriden later.
    #
    # @see https://developer.spotify.com/my-applications/
    #
    def initialize(config)
      opts = {
        site:          "https://api.spotify.com",
        authorize_url: "https://accounts.spotify.com/oauth/authorize",
        token_url:     "https://accounts.spotify.com/api/token"
      }
      validate_initialized_input(config)
      @redirect_uri = config[:redirect_uri]
      super(config[:client_id], config[:client_secret], opts)
    end

    ##
    # Get a HTTP URL to send user for authorizing with Spotify.
    #
    # @example
    #
    #   @auth = Spotify::Auth.new({
    #     client_id: "[client id goes here]",
    #     client_secret: "[client secret goes here]",
    #     redirect_uri: "http://localhost"
    #   })
    #
    #   @auth.authorize_url
    #
    # @param [Hash] override_params Optional hash containing any overriding values for parameters.
    # Parameters used are client_id, redirect_uri, response_type and scope.
    #
    # @see https://developer.spotify.com/web-api/authorization-guide/
    #
    def authorize_url(override_params={})
      super({
        client_id:     id,
        redirect_uri:  redirect_uri,
        response_type: "code",
        scope:         SCOPES.join(" ")
      }.merge(override_params))
    end

    private

    ##
    # OAuth2::Client does not support redirect_uri at initialization, so we store
    # it in the instance and call it later. We think it makes things clearer.
    #
    attr_accessor :redirect_uri

    ##
    # Validate initialization configuration and raise errors.
    #
    # @param [Hash] config OAuth configuration containing the Client ID, secret and redirect URL.
    #
    def validate_initialized_input(config)
      raise Errors::AuthClientCredentialsError.new(OAUTH_I18N[:must_be_hash]) unless config.is_a?(Hash)

      %i[client_id client_secret].each do |key|
        raise Errors::AuthClientCredentialsError.new(OAUTH_I18N[:require_attr] % key) unless config.has_key?(key)
      end
    end
  end

  class Errors
    ##
    # A Error class for when authentication client credentials are empty or incorrectly formatted.
    #
    class AuthClientCredentialsError < StandardError; end
  end
end
