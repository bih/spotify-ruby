# frozen_string_literal: true

require "spotify/sdk/initialization"

module Spotify
  class SDK
    def initialize(obj)
      payload = Spotify::SDK::Initialization.detect(obj)
      @access_token  = payload[:access_token]
      @expires_at    = payload[:expires_at]
      @refresh_token = payload[:refresh_token]
    end

    attr_reader :access_token, :expires_at, :refresh_token
  end

  class Errors
  end
end
