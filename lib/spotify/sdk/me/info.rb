# frozen_string_literal: true

module Spotify
  class SDK
    class Me
      class Info < Model
        ##
        # Get the user's birthdate.
        # Requires the `user-read-birthdate` scope, otherwise it will return nil.
        #
        # @example
        #   @sdk.me.info.birthdate # => Wed, 10 May 1985
        #
        # @return [Date,NilClass] birthdate Return the user's birthdate, otherwise return nil.
        #
        def birthdate
          Date.parse(super) if super
        end

        ##
        # Does the user have a valid display_name?
        #
        # @example
        #   @sdk.me.info.display_name? # => false
        #
        # @return [TrueClass,FalseClass] has_display_name Return true if the user has a non-empty display name.
        #
        def display_name?
          !display_name.to_s.empty?
        end

        ##
        # Get the images for the user.
        #
        # @example
        #   @sdk.me.info.images[0].spotify_uri # => "spotify:image:..."
        #   @sdk.me.info.images[0].spotify_url # => "https://profile-images.scdn.co/..."
        #
        # @return [Array] images A list of all user photos wrapped in Spotify::SDK::Image
        #
        def images
          super.map do |image|
            Spotify::SDK::Image.new(image, parent)
          end
        end

        ##
        # Get the Spotify URI for this user.
        # Alias to self.uri
        #
        # @example
        #   @sdk.me.info.spotify_uri # => "spotify:user:..."
        #
        # @return [String] spotify_uri The direct URI to this Spotify resource.
        #
        alias_attribute :spotify_uri, :uri

        ##
        # Get the Spotify HTTP URL for this user.
        # Alias to self.external_urls[:spotify]
        #
        # @example
        #   @sdk.me.info.spotify_url # => "https://open.spotify.com/..."
        #
        # @return [String] spotify_url The direct HTTP URL to this Spotify resource.
        #
        alias_attribute :spotify_url, "external_urls.spotify"
      end
    end
  end
end
