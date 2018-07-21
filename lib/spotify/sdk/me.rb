# frozen_string_literal: true

module Spotify
  class SDK
    class Me < Base
      ##
      # Get the current user's information.
      # Respective information requires the `user-read-private user-read-email user-read-birthdate` scopes.
      # GET /v1/me
      #
      # @example
      #   me = @sdk.me.info
      #
      # @see https://developer.spotify.com/console/get-current-user/
      # @see https://developer.spotify.com/documentation/web-api/reference/users-profile/get-current-users-profile/
      #
      # @param [Hash] override_opts Custom options for HTTParty.
      # @return [Spotify::SDK::Me::Info] user_info Return the user's information.
      #
      def info(override_opts={})
        me_info = send_http_request(:get, "/v1/me", override_opts)
        Spotify::SDK::Me::Info.new(me_info, self)
      end

      ##
      # Get the current user's followed artists. Requires the `user-read-follow` scope.
      # GET /v1/me/following
      #
      # @example
      #   @sdk.me.following
      #
      # @param [Hash] override_opts Custom options for HTTParty.
      # @return [Array] artists A list of followed artists, wrapped in Spotify::SDK::Artist
      #
      def following(override_opts={})
        artists = send_multiple_following_http_requests("/v1/me/following?type=artist&limit=50", override_opts)
        artists.map do |artist|
          Spotify::SDK::Artist.new(artist, self)
        end
      end

      private

      def send_multiple_following_http_requests(http_path, override_opts) # :nodoc:
        request = send_http_request(:get, http_path, override_opts)[:artists]
        artists = request[:items]
        artists << send_multiple_following_http_requests(request[:next][23..-1], override_opts) if request[:next]
        artists.flatten
      end
    end
  end
end
