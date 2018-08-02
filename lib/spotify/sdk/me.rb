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
      # Check if the current user is following N users.
      #
      # @example
      #   artists = %w(3q7HBObVc0L8jNeTe5Gofh 0NbfKEOTQCcwd6o7wSDOHI 3TVXtAsR1Inumwj472S9r4)
      #   @sdk.me.following?(artists, :artist) # => {"3q7HBObVc0L8jNeTe5Gofh" => false, "0NbfKEOTQCcwd6o7wSDOHI" => false, ...}
      #
      #   users = %w(3q7HBObVc0L8jNeTe5Gofh 0NbfKEOTQCcwd6o7wSDOHI 3TVXtAsR1Inumwj472S9r4)
      #   @sdk.me.following?(users, :user) # => {"3q7HBObVc0L8jNeTe5Gofh" => false, "0NbfKEOTQCcwd6o7wSDOHI" => false, ...}
      #
      # @param [Array] list List of Spotify user/artist IDs. Cannot mix user and artist IDs in single request.
      # @param [Symbol] type Either :user or :artist. Checks if follows respective type of account.
      # @param [Hash] override_opts Custom options for HTTParty.
      # @return [Hash] hash A hash containing a key with the ID, and a value that equals is_following (boolean).
      #
      def following?(list, type=:artist, override_opts={})
        raise "Must contain an array" unless list.is_a?(Array)
        raise "Must contain an array of String or Spotify::SDK::Artist" if any_of?(list, [String, Spotify::SDK::Artist])
        raise "type must be either 'artist' or 'user'" unless %i[artist user].include?(type)
        send_is_following_http_requests(list.map {|id| id.try(:id) || id }, type, override_opts)
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
        artists = send_following_http_requests("/v1/me/following?type=artist&limit=50", override_opts)
        artists.map do |artist|
          Spotify::SDK::Artist.new(artist, self)
        end
      end

      private

      def any_of?(array, klasses)
        (array.map(&:class) - klasses).any?
      end

      def send_is_following_http_requests(list, type, override_opts) # :nodoc:
        max_ids = list.first(50)
        remaining_ids = list - max_ids

        ids = max_ids.map {|id| {id.strip => nil} }.inject(&:merge)
        following = send_http_request(
          :get,
          "/v1/me/following/contains?type=%s&ids=%s" % [type, ids.keys.join(",")],
          override_opts
        )
        ids.each_key {|id| ids[id] = following.shift }

        if remaining_ids.any?
          ids.merge(send_is_following_http_requests(remaining_ids, type, override_opts))
        end || ids
      end

      def send_following_http_requests(http_path, override_opts) # :nodoc:
        request = send_http_request(:get, http_path, override_opts)[:artists]
        artists = request[:items]
        artists << send_following_http_requests(request[:next][23..-1], override_opts) if request[:next]
        artists.flatten
      end
    end
  end
end
