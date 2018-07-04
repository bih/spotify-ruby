# frozen_string_literal: true

module Spotify
  class SDK
    class Item < Model
      ##
      # Get the duration.
      #
      # @example
      #   @sdk.connect.playback.item.duration # => 10331
      #
      # @return [Integer] duration_ms In milliseconds, how long the item is.
      #
      alias_attribute :duration, :duration_ms

      ##
      # Is this track explicit?
      #
      # @example
      #   @sdk.connect.playback.item.explicit? # => true
      #
      # @return [TrueClass,FalseClass] is_explicit Returns true if item contains explicit content.
      #
      alias_attribute :explicit?, :explicit

      ##
      # Is this a local track, not a Spotify track?
      #
      # @example
      #   @sdk.connect.playback.item.local? # => false
      #
      # @return [TrueClass,FalseClass] is_local Returns true if item is local to the user.
      #
      alias_attribute :local?, :is_local

      ##
      # Is this a track?
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
      #
      # @example
      #   @sdk.connect.playback.item.spotify_uri # => "spotify:track:..."
      #
      # @return [String] spotify_uri The direct URI to this Spotify resource.
      #
      alias_attribute :spotify_uri, :uri

      ##
      # Get the Spotify HTTP URL for this item.
      #
      # @example
      #   @sdk.connect.playback.item.spotify_url # => "https://open.spotify.com/..."
      #
      # @return [String] spotify_url The direct HTTP URL to this Spotify resource.
      #
      alias_attribute :spotify_url, "external_urls.spotify"
    end
  end
end
