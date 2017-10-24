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
        response = send_http_request(:get, "/v1/me/player/devices", override_opts)
        response[:devices].map do |device|
          device = Spotify::SDK::Connect::Device.new(device)
          device.parent = self
          device
        end
      end
    end
  end
end
