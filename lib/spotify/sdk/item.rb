# frozen_string_literal: true

module Spotify
  class SDK
    class Item < Model
      ##
      # Let's transform the item object into better for us.
      # Before: { track: ..., played_at: ..., context: ... }
      # After: { track_properties..., played_at: ..., context: ... }
      #
      # :nodoc:
      def initialize(payload, parent)
        track      = payload.delete(:track) || payload.delete(:item)
        properties = payload.except(:parent, :device, :repeat_state, :shuffle_state)
        super(track.merge(properties: properties), parent)
      end

      ##
      # Get the album for this item.
      #
      # @example
      #   @sdk.connect.playback.item.album
      #
      # @return [Spotify::SDK::Album] album The album object, wrapped in Spotify::SDK::Album
      #
      def album
        Spotify::SDK::Album.new(super, parent)
      end

      ##
      # Get the artists/creators for this item.
      #
      # @example
      #   @sdk.connect.playback.item.artists
      #
      # @return [Array] artists A list of artists, wrapped in Spotify::SDK::Artist
      #
      def artists
        super.map do |artist|
          Spotify::SDK::Artist.new(artist, parent)
        end
      end

      ##
      # Get the primary artist/creator for this item.
      #
      # @example
      #   @sdk.connect.playback.item.artist
      #
      # @return [Spotify::SDK::Artist] artist The primary artist, wrapped in Spotify::SDK::Artist
      #
      def artist
        artists.first
      end

      ##
      # Get the duration.
      # Alias to self.duration_ms
      #
      # @example
      #   @sdk.connect.playback.item.duration # => 10331
      #
      # @return [Integer] duration_ms In milliseconds, how long the item is.
      #
      alias_attribute :duration, :duration_ms

      ##
      # Is this track explicit?
      # Alias to self.explicit
      #
      # @example
      #   @sdk.connect.playback.item.explicit? # => true
      #
      # @return [TrueClass,FalseClass] is_explicit Returns true if item contains explicit content.
      #
      alias_attribute :explicit?, :explicit

      ##
      # Is this a local track, not a Spotify track?
      # Alias to self.is_local
      #
      # @example
      #   @sdk.connect.playback.item.local? # => false
      #
      # @return [TrueClass,FalseClass] is_local Returns true if item is local to the user.
      #
      alias_attribute :local?, :is_local

      ##
      # Is this a playable track?
      # Alias to self.is_playable
      #
      # @example
      #   @sdk.connect.playback.item.playable? # => false
      #
      # @return [TrueClass,FalseClass] is_playable Returns true if item is playable.
      #
      alias_attribute :playable?, :is_playable

      ##
      # Is this a track?
      # Alias to self.type == "track"
      #
      # @example
      #   @sdk.connect.playback.item.track? # => true
      #
      # @return [TrueClass,FalseClass] is_track Returns true if item is an music track.
      #
      def track?
        type == "track"
      end

      ##
      # Get the Spotify URI for this item.
      # Alias to self.uri
      #
      # @example
      #   @sdk.connect.playback.item.spotify_uri # => "spotify:track:..."
      #
      # @return [String] spotify_uri The direct URI to this Spotify resource.
      #
      alias_attribute :spotify_uri, :uri

      ##
      # Get the Spotify HTTP URL for this item.
      # Alias to self.external_urls[:spotify]
      #
      # @example
      #   @sdk.connect.playback.item.spotify_url # => "https://open.spotify.com/..."
      #
      # @return [String] spotify_url The direct HTTP URL to this Spotify resource.
      #
      alias_attribute :spotify_url, "external_urls.spotify"

      ##
      # Get the ISRC for this track.
      #
      # @example
      #   @sdk.connect.playback.item.isrc # => "USUM00000000"
      #
      # @return [String] isrc The ISRC string for this track.
      #
      alias_attribute :isrc, "external_ids.isrc"
    end
  end
end
