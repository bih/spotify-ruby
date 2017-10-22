# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class Base
        def initialize(subject)
          @subject = subject
        end

        def should_perform?
          false
        end

        def perform
          {
            access_token:  nil,
            expires_at:    nil,
            refresh_token: nil
          }
        end

        attr_accessor :subject
      end
    end
  end
end
