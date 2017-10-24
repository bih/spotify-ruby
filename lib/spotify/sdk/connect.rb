# frozen_string_literal: true

module Spotify
  class SDK
    class Connect < Base
      ##
      # Collect all the user's available devices.
      # GET /v1/me/player/devices
      #
      # @example
      #   @sdk.connect.devices # => [#<Spotify::SDK::Connect::Device:...>, ...]
      #
      # @see https://developer.spotify.com/web-api/console/get-users-available-devices/
      #
      # @param [Hash] override_opts Custom options for HTTParty.
      # @return
      #
      def devices(override_opts={})
        resp = self.class.get("/v1/me/player/devices", @options.merge(override_opts))
        handle_response(resp)[:devices].map do |device|
          Spotify::SDK::Connect::Device.new(device)
        end
      end
    end
  end
end
