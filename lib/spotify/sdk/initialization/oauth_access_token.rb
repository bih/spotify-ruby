# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class OAuthAccessToken < Base
        def should_perform?
          subject.is_a?(OAuth2::AccessToken)
        end

        def perform
          {
            access_token:  subject.token,
            expires_at:    subject.expires_at,
            refresh_token: subject.refresh_token
          }
        end
      end
    end
  end
end
