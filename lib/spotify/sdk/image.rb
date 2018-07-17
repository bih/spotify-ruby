# frozen_string_literal: true

module Spotify
  class SDK
    class Image < Model
      ##
      # Get the ID of the image.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.images[0].id # => "941223d904f006c4d998598272d43d94"
      #
      # @return [String] image_id The image ID generated from Spotify.
      #
      def id
        url.match(/[a-z0-9]+$/i)[0]
      end

      ##
      # Get the mobile-related link for the image. Designed for offline mobile apps.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.images[0].spotify_uri # => "spoitfy:image:..."
      #
      # @return [String] spotify_uri The mobile-embeddable image for the item.
      #
      def spotify_uri
        "spotify:image:%s" % id
      end

      ##
      # Get the HTTP link for the image. Designed for web apps.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.images[0].spotify_url # => "https://i.scdn.co/image/..."
      #
      # @return [String] spotify_url The web-embeddable HTTP image for the item.
      #
      alias_attribute :spotify_url, :url
    end
  end
end
