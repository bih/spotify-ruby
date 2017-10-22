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
        devices = handle_response(self.class.get("/v1/me/player/devices", @options.merge(override_opts)))[:devices]
        devices.map do |device|
          Spotify::SDK::Connect::Device.new(device)
        end
      end
    end
  end
end
