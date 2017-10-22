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
            expires_at:    nil,
            refresh_token: nil
          }
        end
      end
    end
  end
end
