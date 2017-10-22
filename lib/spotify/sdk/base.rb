# frozen_string_literal: true

module Spotify
  class SDK
    class Base
      include HTTParty
      base_uri 'api.spotify.com'
    end
  end
end
