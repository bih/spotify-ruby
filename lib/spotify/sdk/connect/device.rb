# frozen_string_literal: true

module Spotify
  class SDK
    class Connect
      class Device < Model
        ##
        # Transfer a user's playback to another device, and continue playing.
        # PUT /v1/me/player
        #
        # @example
        #   device = @sdk.connect.transfer_playback!
        #
        # @see https://developer.spotify.com/web-api/transfer-a-users-playback/
        #
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def transfer_playback!
          transfer_playback_method(playing: true)
          self
        end

        ##
        # Transfer a user's playback to another device, and pause.
        # PUT /v1/me/player
        #
        # @example
        #   device = @sdk.connect.transfer_state!
        #
        # @see https://developer.spotify.com/web-api/transfer-a-users-playback/
        #
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def transfer_state!
          transfer_playback_method(playing: false)
          self
        end

        private

        def transfer_playback_method(playing:)
          override_opts = {
            _sdk_opts: {expect_nil: true},
            body:      {
              device_ids: [id],
              play:       playing
            }.to_json
          }

          parent.send_http_request(:put, "/v1/me/player", override_opts)
        end
      end
    end
  end
end
