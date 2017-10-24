# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class URLString < Base
        def query_fragment_string
          @query_fragment_string ||= begin
            @uri = begin
                     URI.parse(subject)
                   rescue URI::InvalidURIError
                     URI.parse("")
                   end
            [@uri.query, @uri.fragment].compact.join("&")
          end
        end

        def should_perform?
          subject.is_a?(String) && query_fragment_string.present?
        end

        def perform
          QueryString.new(query_fragment_string).perform
        end

        # TODO: Delete this when tests are written.
        # def sample_inputs
        #   [
        #     "http://dev.localhost.com:443/?token=#{SAMPLE_TOKEN}",
        #     "http://dev.localhost.com:443/?token=#{SAMPLE_TOKEN}&expires_in=1234567890",
        #     "http://dev.localhost.com:443/?token=#{SAMPLE_TOKEN}&expires_in=1234567890&refresh_token=#{SAMPLE_TOKEN}",
        #     "http://dev.localhost.com:443/#token=#{SAMPLE_TOKEN}",
        #     "http://dev.localhost.com:443/#token=#{SAMPLE_TOKEN}&expires_in=1234567890",
        #     "http://dev.localhost.com:443/#token=#{SAMPLE_TOKEN}&expires_in=1234567890&refresh_token=#{SAMPLE_TOKEN}",
        #     "http://dev.localhost.com:443/?access_token=#{SAMPLE_TOKEN}",
        #     "http://dev.localhost.com:443/?access_token=#{SAMPLE_TOKEN}&expires_in=1234567890",
        #     "http://dev.localhost.com:443/?access_token=#{SAMPLE_TOKEN}&expires_in=1234567890&refresh_token=#{SAMPLE_TOKEN}",
        #     "http://dev.localhost.com:443/#access_token=#{SAMPLE_TOKEN}",
        #     "http://dev.localhost.com:443/#access_token=#{SAMPLE_TOKEN}&expires_in=1234567890",
        #     "http://dev.localhost.com:443/#access_token=#{SAMPLE_TOKEN}&expires_in=1234567890&refresh_token=#{SAMPLE_TOKEN}",
        #     "http://dev.localhost.com:443/?access_token=#{SAMPLE_TOKEN}&expires_in=1234567890#refresh_token=#{SAMPLE_TOKEN}"
        #   ]
        # end
      end
    end
  end
end
