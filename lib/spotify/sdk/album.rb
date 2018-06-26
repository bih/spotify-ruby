# frozen_string_literal: true

module Spotify
  class SDK
    class Album < Model
      ##
      # Is this an album?
      # Note: This is mostly to support other types of albums in the future.
      #
      # @example
      #   album = @sdk.connect.playback.item.album
      #   album.album?
      #
      # @return [TrueClass,FalseClass] is_album Returns true if type is an album.
      #
      def album?
        type == "album"
      end

      ##
      # Display the album's images.
      #
      # @example
      #   album = @sdk.connect.playback.item.album
      #   album.images[0] # => [#<Spotify::SDK::Image>, #<Spotify::SDK::Image>, ...]
      #
      # @return [Array] album_images Contains a list of images, wrapped in Spotify::SDK::Image
      #
      def images
        super.map do |image|
          Spotify::SDK::Image.new(image, parent)
        end
      end

      ##
      # Get the artists/creators for this album.
      #
      # @example
      #   @sdk.connect.playback.item.album.artists
      #
      # @return [Array] artists A list of artists, wrapped in Spotify::SDK::Artist
      #
      def artists
        super.map do |artist|
          Spotify::SDK::Artist.new(artist, parent)
        end
      end

      ##
      # Get the primary artist/creator for this album.
      #
      # @example
      #   @sdk.connect.playback.item.album.artist
      #
      # @return [Spotify::SDK::Artist] artist The primary artist, wrapped in Spotify::SDK::Artist
      #
      def artist
        artists.first
      end

      ##
      # Get the Spotify URI for this album.
      # Alias to self.uri
      #
      # @example
      #   @sdk.connect.playback.item.album.spotify_uri # => "spotify:track:..."
      #
      # @return [String] spotify_uri The direct URI to this Spotify resource.
      #
      alias_attribute :spotify_uri, :uri

      ##
      # Get the Spotify HTTP URL for this album.
      # Alias to self.external_urls[:spotify]
      #
      # @example
      #   @sdk.connect.playback.item.album.spotify_url # => "https://open.spotify.com/..."
      #
      # @return [String] spotify_url The direct HTTP URL to this Spotify resource.
      #
      alias_attribute :spotify_url, "external_urls.spotify"
    end
  end
end
