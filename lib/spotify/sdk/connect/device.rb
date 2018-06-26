# frozen_string_literal: true

module Spotify
  class SDK
    class Connect
      class Device < Model
        ##
        # Get the device's volume.
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.volume
        #
        # @return [Integer] volume Get the volume. Between 0 and 100.
        #
        alias_attribute :volume, :volume_percent

        ##
        # Is the device active?
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.active?
        #
        # @return [Boolean] is_active Bool of whether device is active.
        #
        alias_attribute :active?, :is_active

        ##
        # Is the device's session private?
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.private_session?
        #
        # @return [Boolean] is_private_session Bool of whether device has a private session.
        #
        alias_attribute :private_session?, :is_private_session

        ##
        # Is the device restricted?
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.restricted?
        #
        # @return [Boolean] is_restricted Bool of whether device is restricted.
        #
        alias_attribute :restricted?, :is_restricted

        ##
        # Get the currently playing track.
        # Alias to Spotify::SDK::Connect#playback
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.playback
        #
        #   # Same as calling the following:
        #   @sdk.connect.playback
        #
        # @see lib/spotify/sdk/connect.rb
        #
        # @return [Spotify::SDK::Connect::PlaybackState] self Return the playback state object.
        #
        def playback
          parent.playback
        end

        ##
        # Play the currently playing track on device.
        # PUT /v1/me/player/play
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #
        #   # Play from a playlist, album from a specific index in that list.
        #   # For example, play the 9th item on X playlist.
        #   device.play!(index: 5, context: "spotify:album:5ht7ItJgpBH7W6vJ5BqpPr")
        #
        #   # Play any Spotify URI. Albums, artists, tracks, playlists, and more.
        #   device.play!(uri: "spotify:track:5MqkZd7a7u7N7hKMqquL2U")
        #
        #   # Similar to just uri, but you can define the context.
        #   # Useful for playing a track that is part of a playlist, and you want the next
        #   # songs to play from that particular context.
        #   device.play!(uri: "spotify:track:5MqkZd7a7u7N7hKMqquL2U", context: "spotify:album:5ht7ItJgpBH7W6vJ5BqpPr")
        #
        # @see https://developer.spotify.com/console/put-play/
        #
        # @param [Hash] config The play config you'd like to set. See code examples.
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def play!(config)
          payload = case config.keys
                    when %i[index context]
                      {context_uri: config[:context], offset: {position: config[:index]}}
                    when %i[uri]
                      {uris: [config[:uri]]}
                    when %i[uri context]
                      {context_uri: config[:context], offset: {uri: config[:uri]}}
                    else
                      raise "Unrecognized play instructions. See documentation for details."
                    end

          parent.send_http_request(:put, "/v1/me/player/play?device_id=%s" % id, http_options: {expect_nil: true},
                                                                                 body:         payload.to_json)
          self
        end

        ##
        # Resume the currently playing track on device.
        # PUT /v1/me/player/play
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.resume!
        #
        # @see https://developer.spotify.com/console/put-play/
        #
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def resume!
          parent.send_http_request(:put, "/v1/me/player/play?device_id=%s" % id, http_options: {expect_nil: true})
          self
        end

        ##
        # Pause the currently playing track on device.
        # PUT /v1/me/player/pause
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.pause!
        #
        # @see https://developer.spotify.com/console/put-pause/
        #
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def pause!
          parent.send_http_request(:put, "/v1/me/player/pause?device_id=%s" % id, http_options: {expect_nil: true})
          self
        end

        ##
        # Skip to previous track on device.
        # PUT /v1/me/player/previous
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.previous!
        #
        # @see https://developer.spotify.com/console/put-previous/
        #
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def previous!
          parent.send_http_request(:put, "/v1/me/player/previous?device_id=%s" % id, http_options: {expect_nil: true})
          self
        end

        ##
        # Skip to next track on device.
        # PUT /v1/me/player/next
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.next!
        #
        # @see https://developer.spotify.com/console/put-next/
        #
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def next!
          parent.send_http_request(:put, "/v1/me/player/next?device_id=%s" % id, http_options: {expect_nil: true})
          self
        end

        ##
        # Set volume for current device.
        # PUT /v1/me/player/volume
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.change_volume!(30)
        #
        #   # or
        #
        #   device = @sdk.connect.devices[0]
        #   device.volume = 30
        #
        # @see https://developer.spotify.com/console/put-volume/
        #
        # @param [Integer] volume_percent The 0-100 value to change the volume to. 100 is maximum.
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def change_volume!(volume_percent)
          raise "Must be an integer" unless volume_percent.is_a?(Integer)
          endpoint = "/v1/me/player/volume?volume_percent=%i&device_id=%s" % [volume_percent, id]
          opts = {http_options: {expect_nil: true}}
          parent.send_http_request(:put, endpoint, opts)
          self
        end

        alias_method :volume=, :change_volume!

        ##
        # Seek position (in milliseconds) for the currently playing track on the device.
        # PUT /v1/me/player/seek
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.seek_ms!(4000)
        #
        # @see https://developer.spotify.com/console/put-seek/
        #
        # @param [Integer] position_ms In milliseconds, where to seek in the current track on device.
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def seek_ms!(position_ms)
          raise "Must be an integer" unless position_ms.is_a?(Integer)
          endpoint = "/v1/me/player/seek?position_ms=%i&device_id=%s" % [position_ms, id]
          opts = {http_options: {expect_nil: true}}
          parent.send_http_request(:put, endpoint, opts)
          self
        end

        alias_method :position_ms=, :seek_ms!

        ##
        # Set repeat mode for current device.
        # PUT /v1/me/player/repeat
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.repeat!(:track)
        #   device.repeat!(:context)
        #   device.repeat!(:off)
        #
        # @see https://developer.spotify.com/console/put-repeat/
        #
        # @param [Boolean] state What to set the repeat state to - :track, :context, or :off
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def repeat!(state)
          raise "Must be :track, :context, or :off" unless %i[track context off].include?(state)
          endpoint = "/v1/me/player/repeat?state=%s&device_id=%s" % [state, id]
          opts = {http_options: {expect_nil: true}}
          parent.send_http_request(:put, endpoint, opts)
          self
        end

        alias_method :repeat=, :repeat!

        ##
        # Set shuffle for current device.
        # PUT /v1/me/player/shuffle
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.shuffle!(true)
        #
        # @see https://developer.spotify.com/console/put-shuffle/
        #
        # @param [Boolean] state The true/false of if you'd like to set shuffle on.
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def shuffle!(state)
          raise "Must be true or false" unless [true, false].include?(state)
          endpoint = "/v1/me/player/shuffle?state=%s&device_id=%s" % [state, id]
          opts = {http_options: {expect_nil: true}}
          parent.send_http_request(:put, endpoint, opts)
          self
        end

        alias_method :shuffle=, :shuffle!

        ##
        # Transfer a user's playback to another device, and continue playing.
        # PUT /v1/me/player
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.transfer_playback!
        #
        # @see https://developer.spotify.com/console/transfer-a-users-playback/
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
        #   device = @sdk.connect.devices[0]
        #   device.transfer_state!
        #
        # @see https://developer.spotify.com/console/transfer-a-users-playback/
        #
        # @return [Spotify::SDK::Connect::Device] self Return itself, so chained methods can be supported.
        #
        def transfer_state!
          transfer_playback_method(playing: false)
          self
        end

        private

        def transfer_playback_method(playing:) # :nodoc:
          override_opts = {
            http_options: {
              expect_nil: true
            },
            body:         {
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
