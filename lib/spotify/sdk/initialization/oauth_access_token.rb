# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      ##
      # This class implements accepting OAuth2::AccessToken as an initializer.
      #
      class OAuthAccessToken < Base
        ##
        # This implements the #should_perform? method from the Base class.
        #
        # @see /lib/spotify/sdk/authorization/base.rb
        #
        def should_perform?
          subject.instance_of? OAuth2::AccessToken
        end

        ##
        # This implements the #perform method from the Base class.
        #
        # @see /lib/spotify/sdk/authorization/base.rb
        #
        def perform
          {
            access_token:  subject.token,
            expires_in:    subject.expires_in,
            refresh_token: subject.refresh_token
          }
        end
      end
    end
  end
end
