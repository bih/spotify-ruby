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
      # Helper method for setting the following status.
      # Requires the `user-follow-modify` scope.
      # If true, PUT /v1/me/following otherwise DELETE /v1/me/following
      #
      # @example
      #   @sdk.playback.item.artist.following = true
      #   @sdk.playback.item.artist.following = false
      #
      def following=(should_follow)
        raise "#following= must be true or false" unless [true, false].include?(should_follow)
        should_follow ? follow! : unfollow!
      end

      ##
      # Follow the artist.
      # Requires the `user-follow-modify` scope.
      # PUT /v1/me/following
      #
      # @example
      #   @sdk.playback.item.artist.follow!
      #
      # @return [Spotify::SDK::Artist] self Return the artist object, for chaining methods.
      #
      def follow!
        parent.send_http_request(:put, "/v1/me/following?type=artist&ids=%s" % id, http_options: {expect_nil: true})
        self
      end

      ##
      # Unfollow the artist.
      # Requires the `user-follow-modify` scope.
      # DELETE /v1/me/following
      #
      # @example
      #   @sdk.playback.item.artist.unfollow!
      #
      # @return [Spotify::SDK::Artist] self Return the artist object, for chaining methods.
      #
      def unfollow!
        parent.send_http_request(:delete, "/v1/me/following?type=artist&ids=%s" % id, http_options: {expect_nil: true})
        self
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
      # Display the artist's popularity. If not obtained, request them from the API.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.popularity # => 90
      #
      # @return [Integer] popularity The number of popularity, between 0-100.
      #
      def popularity
        retrieve_full_information! unless full_information?
        super
      end

      ##
      # Display the artist's genres. If not obtained, request them from the API.
      #
      # @example
      #   artist = @sdk.connect.playback.artist
      #   artist.genres # => ["hip hop", "pop rap", "rap", ...]
      #
      # @return [Array] genres An array of genres, denoted in strings.
      #
      def genres
        retrieve_full_information! unless full_information?
        super
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
