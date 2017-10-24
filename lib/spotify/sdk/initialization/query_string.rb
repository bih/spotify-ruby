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
          should_be_string = subject.is_a?(String)
          should_have_keys = params.has_key?(:token) && params.has_key?(:access_token)
        end

        def perform
          access_token_key = params.has_key?(:token) ? :token : :access_token

          {
            access_token:  (params[access_token_key][0] rescue nil),
            expires_in:    (params[:expires_in][0] rescue nil),
            refresh_token: (params[:refresh_token][0] rescue nil)
          }
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
