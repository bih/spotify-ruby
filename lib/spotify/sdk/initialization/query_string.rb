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
          subject.is_a?(String) && params.has_key?(:token)
        end

        def perform
          {
            access_token:  params[:token][0].presence,
            expires_at:    params[:expires_at][0],
            refresh_token: params[:refresh_token][0]
          }
        end
      end
    end
  end
end
