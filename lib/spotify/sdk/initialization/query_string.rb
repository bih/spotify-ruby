# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class QueryString < Base
        def params
          CGI.parse(subject).with_indifferent_access
        rescue NoMethodError
          {}
        end

        def should_perform?
          subject.is_a?(String) && (
            params.has_key?(:token) && params.has_key?(:access_token)
          )
        end

        def perform
          {
            access_token:  params[access_token_key].to_a[0],
            expires_in:    params[:expires_in].to_a[0],
            refresh_token: params[:refresh_token].to_a[0]
          }
        end

        private

        def access_token_key
          if params.has_key?(:token)
            :token
          elsif params.has_key?(:access_token)
            :access_token
          end
        end

        # TODO: Delete this when tests are written.
        # def sample_inputs
        #   [
        #     "token=#{SAMPLE_TOKEN}",
        #     "token=#{SAMPLE_TOKEN}&expires_in=1234567890",
        #     "token=#{SAMPLE_TOKEN}&expires_in=1234567890&refresh_token=#{SAMPLE_TOKEN}",
        #     "access_token=#{SAMPLE_TOKEN}",
        #     "access_token=#{SAMPLE_TOKEN}&expires_in=1234567890",
        #     "access_token=#{SAMPLE_TOKEN}&expires_in=1234567890&refresh_token=#{SAMPLE_TOKEN}"
        #   ]
        # end
      end
    end
  end
end
