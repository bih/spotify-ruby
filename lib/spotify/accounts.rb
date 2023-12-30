# frozen_string_literal: true

module Spotify
  ##
  # Spotify::Accounts deals with authorization using the Spotify Accounts API.
  #
  class Accounts
    ##
    # An entire list of Spotify's OAuth scopes. Stored
    # in the form of a symbolized array.
    # Example: `[:scope1, :scope2]`
    #
    # @see https://developer.spotify.com/documentation/general/guides/scopes/
    #
    # Last updated: 23 June 2018
    #
    SCOPES = %i[
      playlist-read-private
      playlist-read-collaborative
      playlist-modify-public
      playlist-modify-private
      ugc-image-upload
      user-follow-modify
      user-follow-read
      user-library-read
      user-library-modify
      user-read-private
      user-read-birthdate
      user-read-email
      user-top-read
      user-read-playback-state
      user-modify-playback-state
      user-read-currently-playing
      user-read-recently-played
      streaming
      app-remote-control
    ].freeze

    ##
    # Initialize the Spotify Accounts object.
    #
    # @example
    #   @accounts = Spotify::Accounts.new({
    #     client_id: "[client id goes here]",
    #     client_secret: "[client secret goes here]",
    #     redirect_uri: "http://localhost"
    #   })
    #
    #   @accounts = Spotify::Accounts.new
    #   @accounts.client_id = "[client id goes here]"
    #   @accounts.client_secret = "[client secret goes here]"
    #   @accounts.redirect_uri = "http://localhost"
    #
    #   # with SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET, and SPOTIFY_REDIRECT_URI in ENV:
    #   @accounts = Spotify::Accounts.new
    #
    # @param [Hash] config The configuration containing your Client ID, Client Secret, and your Redirect URL.
    #
    # @see https://developer.spotify.com/dashboard/
    #
    def initialize(config={})
      @client_id = config.delete(:client_id) { ENV["SPOTIFY_CLIENT_ID"] }
      @client_secret = config.delete(:client_secret) { ENV["SPOTIFY_CLIENT_SECRET"] }
      @redirect_uri = config.delete(:redirect_uri) { ENV["SPOTIFY_REDIRECT_URI"] }
    end

    attr_accessor :client_id, :client_secret, :redirect_uri

    ##
    # Get a HTTP URL to send user for authorizing with Spotify.
    #
    # @example
    #   @accounts = Spotify::Accounts.new({
    #     client_id: "[client id goes here]",
    #     client_secret: "[client secret goes here]",
    #     redirect_uri: "http://localhost"
    #   })
    #
    #   @auth.authorize_url
    #   @auth.authorize_url({ scope: "user-read-private user-top-read" })
    #
    # @param [Hash] override_params Optional hash containing any overriding values for parameters.
    # Parameters used are client_id, redirect_uri, response_type and scope.
    # @return [String] A fully qualified Spotify authorization URL to send the user to.
    #
    # @see https://developer.spotify.com/documentation/general/guides/authorization-guide/
    #
    def authorize_url(override_params={})
      validate_credentials!
      params = {
        client_id:     @client_id,
        redirect_uri:  @redirect_uri,
        response_type: "code",
        scope:         SCOPES.join(" ")
      }.merge(override_params)
      "https://accounts.spotify.com/authorize?%s" % params.to_query
    end

    ##
    # Start a session from your authentication code.
    #
    # @example
    #   @accounts = Spotify::Accounts.new({
    #     client_id: "[client id goes here]",
    #     client_secret: "[client secret goes here]",
    #     redirect_uri: "http://localhost"
    #   })
    #
    #   @accounts.exchange_for_session("code")
    #
    # @param [String] code The code provided back to your application upon authorization.
    # @return [Spotify::Accounts::Session] session The session object.
    #
    # @see https://developer.spotify.com/documentation/general/guides/authorization-guide/
    #
    def exchange_for_session(code)
      validate_credentials!
      Spotify::Accounts::Session.from_authorization_code(self, code)
    end

    def inspect # :nodoc:
      "#<%s:0x00%x>" % [self.class.name, (object_id << 1)]
    end

    private

    def validate_credentials! # :nodoc:
      raise "Missing client id" if @client_id.nil?
      raise "Missing client secret" if @client_secret.nil?
      raise "Missing redirect uri" if @redirect_uri.nil?
    end
  end
end
