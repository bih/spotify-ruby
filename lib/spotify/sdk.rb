# frozen_string_literal: true

require "spotify/sdk/initialization"

module Spotify
  ##
  # Spotify::SDK contains a variety of commands you can do .
  #
  class SDK
    def initialize(obj)
      payload = Spotify::SDK::Initialization.detect(obj)
      @access_token  = payload[:access_token]
      @expires_at    = payload[:expires_at]
      @refresh_token = payload[:refresh_token]
    end

    def oauth2_access_token(auth)
      OAuth2::AccessToken.new(auth, @access_token, expires_at:    @expires_at,
                                                   refresh_token: @refresh_token)
    end

    attr_reader :access_token, :expires_at, :refresh_token
  end

  class Errors
  end
end
