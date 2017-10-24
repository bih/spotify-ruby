# frozen_string_literal: true

module Spotify
  class SDK
    class Connect
      class Device < OpenStruct
        PAUSED  = 0.freeze
        PLAYING = 1.freeze

        ##
        # Transfer a user's playback to another device.
        # PUT /v1/me/player
        #
        # @example
        #   device = @sdk.connect.transfer_playback!
        #   device = @sdk.connect.transfer_playback!(Spotify::SDK::Connect::Device::PAUSED)
        #   device = @sdk.connect.transfer_playback!(Spotify::SDK::Connect::Device::PLAYING)
        #
        # @see https://developer.spotify.com/web-api/transfer-a-users-playback/
        #
        # @param [Spotify::SDK::Connect::Device::PLAYING,Spotify::SDK::Connect::Device::PAUSED] state Upon successful transfer, change state to pause or playing.
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def transfer_playback!(state=PLAYING)
          override_opts = {
            sdk: { expect_nil: true },
            body: {
              device_ids: [self.id],
              play:       state == 1
            }.to_json
          }

          parent.send_http_request(:put, "/v1/me/player", override_opts)
          self
        end

        ##
        # A reference to Spotify::SDK::Connect, so we can also do stuff.
        #
        attr_accessor :parent
      end
    end
  end
end
