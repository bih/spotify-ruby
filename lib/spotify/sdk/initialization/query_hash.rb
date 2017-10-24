# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class QueryHash < Base
        def subject_hash
          subject.try(:with_indifferent_access) || {}
        end

        def should_perform?
          subject_hash.has_key?(:token) || subject_hash.has_key?(:access_token)
        end

        def perform
          subject_hash[:access_token] = subject_hash[:token] if subject_hash.has_key?(:token)
          subject_hash.slice(:access_token, :expires_in, :refresh_token).symbolize_keys
        end
        
        # TODO: Delete this when tests are written.
        # def sample_inputs
        #   [{
        #     token: SAMPLE_TOKEN
        #   }, {
        #     token:      SAMPLE_TOKEN,
        #     expires_in: 1234567890
        #   }, {
        #     token:         SAMPLE_TOKEN,
        #     expires_in:    1234567890,
        #     refresh_token: SAMPLE_TOKEN
        #   }, {
        #     access_token: SAMPLE_TOKEN
        #   }, {
        #     access_token: SAMPLE_TOKEN,
        #     expires_in:   1234567890
        #   }, {
        #     access_token:  SAMPLE_TOKEN,
        #     expires_in:    1234567890,
        #     refresh_token: SAMPLE_TOKEN
        #   }]
        # end
      end
    end
  end
end
