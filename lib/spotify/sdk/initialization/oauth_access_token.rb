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
            expires_in:    subject.expires_in,
            refresh_token: subject.refresh_token
          }
        end

        # TODO: Delete this when tests are written.
        # def sample_inputs
        #   client = OAuth2::Client.new({
        #     client_id:     "client id",
        #     client_secret: "client secret",
        #     redirect_uri:  "http://localhost"
        #   })

        #   [
        #     OAuth2::AccessToken.new(client, SAMPLE_TOKEN, {}),
        #     OAuth2::AccessToken.new(client, SAMPLE_TOKEN, { expires_in: 1234567890 }),
        #     OAuth2::AccessToken.new(client, SAMPLE_TOKEN, { expires_in: 1234567890, refresh_token: SAMPLE_TOKEN })
        #   ]
        # end
      end
    end
  end
end
