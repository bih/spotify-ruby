# frozen_string_literal: true

module Spotify
  class SDK
    class Me < Base
      ##
      # Get the current user's information.
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
    end
  end
end
