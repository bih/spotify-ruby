# frozen_string_literal: true

require "oauth2"

module Spotify
  class Auth < OAuth2::Client
    # Updated 21 October 2017
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

    def initialize(config)
      opts = {
        site:          "https://api.spotify.com",
        authorize_url: "https://accounts.spotify.com/oauth/authorize"
      }
      validate_initialized_input(config)
      @redirect_uri = config[:redirect_uri]
      super(config[:client_id], config[:client_secret], opts)
    end

    def authorize_url(opts={})
      super({
        client_id:     id,
        redirect_uri:  redirect_uri,
        response_type: "code",
        scope:         SCOPES.join(" ")
      }.merge(opts))
    end

    private

    attr_accessor :redirect_uri

    OAUTH_I18N = {
      must_be_hash: "Must be a Hash. Example: Spotify::Auth.new({ client_id: '', ... })",
      require_attr: "Expecting a '%s' key. You can obtain from https://developer.spotify.com"
    }.freeze

    def validate_initialized_input(config)
      raise Errors::AuthClientCredentialsError.new(OAUTH_I18N[:must_be_hash]) unless config.is_a?(Hash)

      %i[client_id client_secret redirect_uri].each do |key|
        raise Errors::AuthClientCredentialsError.new(OAUTH_I18N[:require_attr] % key) unless config.has_key?(key)
      end
    end
  end

  class Errors
    class AuthClientCredentialsError < StandardError; end
  end
end
