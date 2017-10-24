# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class PlainString < Base
        def should_perform?
          subject.is_a?(String) && subject =~ /^[a-zA-Z0-9_-]+$/
        end

        def perform
          {
            access_token:  subject,
            expires_in:    nil,
            refresh_token: nil
          }
        end

        # TODO: Delete this when tests are written.
        # def sample_inputs
        #   [ SAMPLE_TOKEN ]
        # end
      end
    end
  end
end
