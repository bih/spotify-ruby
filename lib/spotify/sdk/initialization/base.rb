# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class Base < Struct.new(:subject)
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
      end
    end
  end
end
