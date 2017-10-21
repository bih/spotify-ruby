# frozen_string_literal: true

require "oauth2"

module Spotify
  class Auth < OAuth2::Client
    def initialize(client_id, client_secret)
      opts = {
        site: "https://api.spotify.com",
        authorize_url: "https://accounts.spotify.com/oauth/authorize"
      }

      super(client_id, client_secret, opts)
    end
  end
end
