# frozen_string_literal: true

module Spotify
  class SDK
    ##
    # For each SDK component, we have a Base class. We're using HTTParty.
    #
    class Base
      include HTTParty
      base_uri "api.spotify.com:443"

      ##
      # Initiate a Spotify SDK Base component.
      #
      # @example
      #   @sdk = Spotify::SDK.new(@session)
      #   @auth = Spotify::SDK::Base.new(@sdk)
      #
      #   @sdk = Spotify::SDK.new(@session)
      #   @sdk.to_hash # => { access_token: ..., expires_at: ... }
      #
      # @param [Spotify::SDK] parent An instance of Spotify::SDK as a reference point.
      #
      def initialize(parent)
        @parent = parent
        @options = {
          headers: {
            Authorization: "Bearer %s" % @parent.session.access_token
          }
        }
      end

      ##
      # Handle HTTParty responses.
      #
      # @example
      #   # Return the Hash from the JSON response.
      #   send_http_request(:get, "/v1/me/player/devices", @options)
      #
      #   # Return the raw HTTParty::Response object.
      #   send_http_request(:get, "/v1/me/player/devices", @options.merge({http_options: { raw: true }}))
      #
      #   # Return true for HTTP requests that return a 200 OK with an empty response.
      #   send_http_request(:put, "/v1/me/player/pause", @options.merge({http_options: { expect_nil: true }}))
      #
      # @param [Symbol] method The HTTP method you want to perform. Examples are :get, :post, :put, :delete
      # @param [String] endpoint The HTTP endpoint you'd like to call. Example: /v1/me
      # @param [Hash] override_opts Any headers, HTTParty config or application-specific config (see `http_options`)
      # @return [Hash,HTTParty::Response,TrueClass] response The response from the HTTP request.
      #
      # TODO: Address and fix cyclomatic & code complexity issues by Rubocop.
      # rubocop:disable CyclomaticComplexity, PerceivedComplexity, AbcSize
      def send_http_request(method, endpoint, override_opts={})
        opts = {
          raw:        false,
          expect_nil: false
        }.merge(override_opts[:http_options].presence || {})

        httparty = self.class.send(method, endpoint, @options.merge(override_opts))
        response = httparty.parsed_response
        response = response.try(:deep_symbolize_keys) || response
        raise response[:error][:message] if response.is_a?(Hash) && response[:error].present?
        return httparty if opts[:raw] == true

        response = opts[:expect_nil] ? true : raise("No response returned") if response.nil?
        response
      end
      # rubocop:enable CyclomaticComplexity, PerceivedComplexity, AbcSize

      def inspect # :nodoc:
        "#<%s:0x00%x>" % [self.class.name, (object_id << 1)]
      end

      attr_reader :parent
    end
  end
end
