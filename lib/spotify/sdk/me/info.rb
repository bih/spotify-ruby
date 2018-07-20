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
      end
    end
  end
end
