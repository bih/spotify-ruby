# frozen_string_literal: true

module Spotify
  class SDK
    class Connect < Base
      ##
      # Get the current playback.
      # GET /v1/me/player
      #
      # @example
      #   playback = @sdk.connect.playback
      #
      # @see https://developer.spotify.com/console/get-user-player/
      # @see https://developer.spotify.com/documentation/web-api/reference/player/get-information-about-the-users-current-playback/
      #
      # @param [String] market The market you'd like to request.
      # @param [Hash] override_opts Custom options for HTTParty.
      # @return [Spotify::SDK::Connect::PlaybackState] self Return the playback state object.
      #
      def playback(market="from_token", override_opts={})
        playback_state = send_http_request(:get, "/v1/me/player?market=%s" % market, override_opts)
        Spotify::SDK::Connect::PlaybackState.new(playback_state, self)
      end

      ##
      # Collect all the user's available devices.
      # GET /v1/me/player/devices
      #
      # @example
      #   @sdk.connect.devices # => [#<Spotify::SDK::Connect::Device:...>, ...]
      #
      # @see https://developer.spotify.com/console/get-users-available-devices/
      #
      # @param [Hash] override_opts Custom options for HTTParty.
      # @return [Array] devices A list of all devices.
      #
      def devices(override_opts={})
        response = send_http_request(:get, "/v1/me/player/devices", override_opts)
        response[:devices].map do |device|
          Spotify::SDK::Connect::Device.new(device, self)
        end
      end

      ##
      # Collect all the active devices.
      #
      # @example
      #   @sdk.connect.active_devices # => [#<Spotify::SDK::Connect::Device:...>, ...]
      #
      # @see https://developer.spotify.com/console/get-users-available-devices/
      #
      # @param [Hash] override_opts Custom options for HTTParty.
      # @return [Array] devices A list of all devices that are marked as `is_active`.
      #
      def active_devices(override_opts={})
        devices(override_opts).select {|device| device.is_active == true }
      end

      ##
      # Collect the first active device.
      #
      # @example
      #   @sdk.connect.active_device # => #<Spotify::SDK::Connect::Device:...>
      #
      # @see https://developer.spotify.com/console/get-users-available-devices/
      #
      # @param [Hash] override_opts Custom options for HTTParty.
      # @return [Array,NilClass] device The first device with `is_active`. If no device found, returns `nil`.
      #
      def active_device(override_opts={})
        devices(override_opts).find {|device| device.is_active == true }
      end
    end
  end
end
