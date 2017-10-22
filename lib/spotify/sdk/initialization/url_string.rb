# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class URLString < Base
        def query_fragment_string
          @query_fragment_string ||= begin
            @uri = URI.parse(subject) rescue URI.parse("")
            [@uri.query, @uri.fragment].compact.join("&")
          end
        end

        def should_perform?
          subject.is_a?(String) && query_fragment_string.present?
        end

        def perform
          QueryString.new(query_fragment_string).perform
        end
      end
    end
  end
end
