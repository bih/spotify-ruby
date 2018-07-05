# frozen_string_literal: true

module Spotify
  class SDK
    class Connect
      class PlaybackState < Model
        ##
        # Get the device the current playback is on.
        #
        # @example
        #   device = @sdk.connect.devices[0]
        #   device.playback.device
        #
        # @return [Spotify::SDK::Connect::Device] self Return the device object.
        #
        def device
          Spotify::SDK::Connect::Device.new(super, parent)
        end

        ##
        # Is the current user playing a track?
        #
        # @example
        #   playback = @sdk.connect.playback
        #   playback.playing?
        #
        # @return [FalseClass,TrueClass] is_playing True if user is currently performing playback.
        #
        alias_attribute :playing?, :is_playing

        ##
        # Is the current playback set to shuffle?
        #
        # @example
        #   playback = @sdk.connect.playback
        #   playback.shuffling?
        #
        # @return [FalseClass,TrueClass] is_shuffling True if shuffle is set.
        #
        alias_attribute :shuffling?, :shuffle_state

        ##
        # What repeat mode is the current playback set to?
        #
        # Options:
        #   :off => This means no repeat is set.
        #   :context => This means it will repeat within the same context.
        #   :track => This will repeat the same track.
        #
        # @example
        #   playback = @sdk.connect.playback
        #   playback.repeat # :off, :context, or :track
        #
        # @return [Symbol] repeat_mode Either :off, :context, or :track
        #
        def repeat_mode
          repeat_state.to_sym
        end

        ##
        # The current timestamp of the playback state
        #
        # @example
        #   playback = @sdk.connect.playback
        #   playback.time
        #
        # @return [Time] time The accuracy time of the playback state.
        #
        def time
          Time.at(timestamp / 1000)
        end

        ##
        # What is the current position of the track?
        #
        # @example
        #   playback = @sdk.connect.playback
        #   playback.position
        #
        # @return [Integer] position_ms In milliseconds, the position of the track.
        #
        alias_attribute :position, :progress_ms

        ##
        # How much percentage of the track is the position currently in?
        #
        # @example
        #   playback = @sdk.connect.playback
        #   playback.position_percentage # => 7.30
        #   playback.position_percentage(4) # => 7.3039
        #
        # @param [Integer] decimal_points How many decimal points to return
        # @return [Float] percentage Completion percentage. Rounded to 2 decimal places.
        #
        def position_percentage(decimal_points=2)
          ((position.to_f / item.duration.to_f) * 100).ceil(decimal_points)
        end

        ##
        # Get the artists for the currently playing track.
        #
        # @example
        #   @sdk.connect.playback.artists
        #
        # @return [Array] artists An array of artists wrapped in Spotify::SDK::Artist
        #
        def artists
          item[:artists].map do |artist|
            Spotify::SDK::Artist.new(artist, parent)
          end
        end

        ##
        # Get the main artist for the currently playing track.
        #
        # @example
        #   @sdk.connect.playback.artist
        #
        # @return [Spotify::SDK::Artist] artist The main artist of the track.
        #
        def artist
          artists.first
        end

        ##
        # Get the item for the currently playing track.
        #
        # @example
        #   @sdk.connect.playback.item
        #
        # @return [Spotify::SDK::Item] item The currently playing track, wrapped in Spotify::SDK::Item
        #
        def item
          Spotify::SDK::Item.new(super, parent)
        end
      end
    end
  end
end
