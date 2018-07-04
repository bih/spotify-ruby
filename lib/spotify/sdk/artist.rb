# frozen_string_literal: true

module Spotify
  class SDK
    class Artist < Model
      ##
      # Do we have the full information for this artist?
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.full_information? # => false
      #
      # @return [FalseClass,TrueClass] is_full_info Does this contain everything?
      #
      def full_information?
        to_h.key?(:images)
      end

      ##
      # Get full information for this artist by calling /v1/artists/{id}.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.retrieve_full_information! unless artist.full_information?
      #
      # @return [TrueClass] success Always returns true.
      #
      def retrieve_full_information!
        unless full_information?
          parent.send_http_request(:get, "/v1/artists/%s" % id).map do |key, value|
            send("%s=" % key, value)
          end
        end

        true
      end

      ##
      # Display the artist's images. If not obtained, request them from the API.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.images[0] # => [#<Spotify::SDK::Image>, #<Spotify::SDK::Image>, ...]
      #
      # @return [Array] images Contains a list of images, wrapped in Spotify::SDK::Image
      #
      def images
        retrieve_full_information! unless full_information?
        super.map {|image| Spotify::SDK::Image.new(image, parent) }
      end

      ##
      # Return the Spotify URL for this artist.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.spotify_url # => "https://open.spotify.com/artist/..."
      #
      # @return [String] spotify_url The URL to open this artist on open.spotify.com
      #
      def spotify_url
        external_urls[:spotify]
      end

      ##
      # Return the Spotify URI for this artist.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.spotify_uri # => "spotify:uri:..."
      #
      # @return [String] spotify_uri The URI to open this artist in official apps.
      #
      alias_attribute :spotify_uri, :uri

      ##
      # Return the followers on Spotify for this artist.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.followers # => 13913
      #
      # @return [Integer] followers The number of users following this artist.
      #
      def followers
        super[:total]
      end
    end
  end
end
