# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class QueryHash < Base
        def subject_hash
          subject.try(:with_indifferent_access) || {}
        end

        def should_perform?
          subject_hash.has_key?(:access_token)
        end

        def perform
          subject_hash.slice(:access_token, :expires_at, :refresh_token).symbolize_keys
        end
      end
    end
  end
end
