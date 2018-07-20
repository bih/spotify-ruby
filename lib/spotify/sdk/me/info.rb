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
      end
    end
  end
end
