# frozen_string_literal: true

require "oauth2"

module Spotify
  class Auth < OAuth2::Client
    def new(client_id, client_secret)
      super(client_id, client_secret, site: "https://api.spotify.com")
    end
  end
end
