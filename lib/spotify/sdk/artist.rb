# frozen_string_literal: true

module Spotify
  class SDK
    class Artist < Model
      ##
      # Do we have the full information for this artist?
      #
      # @return [FalseClass,TrueClass] is_full_info Does this contain everything?
      #
      def full_information?
        images.present?
      end

      ##
      # Get full information for this artist by calling /v1/artists/{id}.
      #
      #
      def retrieve_full_information!
        parent.send_http_request(:get, "/v1/artists/%s" % id).map do |key, value|
          send("%s=" % key, value)
        end

        nil
      end

      ##
      # Return the Spotify URL for this artist.
      #
      # @return [String] spotify_url The URL to open this artist on open.spotify.com
      #
      def spotify_url
        external_urls[:spotify]
      end

      ##
      # Return the Spotify URI for this artist.
      #
      # @return [String] spotify_uri The URI to open this artist in official apps.
      #
      alias_attribute :spotify_uri, :uri

      ##
      # Return the followers on Spotify for this artist.
      #
      # @return [Integer] followers The number of users following this artist.
      #
      def followers
        super[:total]
      end
    end
  end
end
