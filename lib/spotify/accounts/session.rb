# frozen_string_literal: true

module Spotify
  class Accounts
    ##
    # A class representing an access token, with the ability to refresh.
    #
    class Session
      class << self
        ##
        # Parse the response we collect from the authorization code.
        #
        # @example
        #   @session = Spotify::Accounts.from_authorization_code(@accounts, "authorization code here")
        #
        # @param [Spotify::Accounts] accounts A valid instance of Spotify::Accounts.
        # @param [String] code The code provided in the Redirect URI from the Spotify Accounts API.
        # @return [Spotify::Accounts::Session] access_token An instance of Spotify::Accounts::Session
        # @see lib/spotify/accounts.rb
        #
        def from_authorization_code(accounts, code)
          params = {
            client_id:     @accounts.instance_variable_get(:@client_id),
            client_secret: @accounts.instance_variable_get(:@client_secret),
            redirect_uri:  @accounts.instance_variable_get(:@redirect_uri),
            grant_type:    "authorization_code",
            code:          code
          }
          request = HTTParty.post("https://accounts.spotify.com/api/token", body: params)
          response = request.parsed_response.with_indifferent_access
          raise response[:error_description] if response[:error]

          new(accounts, response[:access_token], response[:expires_in], response[:refresh_token], response[:scope])
        end

        ##
        # Set up an instance of Access Token with just a refresh_token.
        #
        # @example
        #   @access_token = Spotify::Accounts::Session.from_refresh_token(@accounts, "refresh token here")
        #   @access_token.force_refresh!
        #
        # @param [Spotify::Accounts] accounts A valid instance of Spotify::Accounts.
        # @param [String] refresh_token A valid refresh token. You'll want to store the refresh_token in your database.
        # @return [Spotify::Accounts::Session] access_token An instance of Spotify::Accounts::Session
        #
        def from_refresh_token(accounts, refresh_token)
          new(accounts, nil, nil, refresh_token, nil)
        end
      end

      def initialize(accounts, access_token, expires_in, refresh_token, scopes)
        unless accounts.instance_of?(Spotify::Accounts)
          raise "You need a valid Spotify::Accounts instance in order to use Spotify authentication."
        end

        @accounts = accounts
        @access_token = access_token
        @expires_in = expires_in
        @expires_at = expires_in + Time.now.to_i unless expires_in.nil?
        @refresh_token = refresh_token
        @scopes = scopes
      end

      attr_reader :accounts, :access_token, :expires_in, :refresh_token

      ##
      # Converts the space-delimited scope list to a symbolized array.
      #
      # @example
      #   @access_token.scopes # => [:"user-read-private", :"user-top-read", ...]
      #
      # @return [Array] scopes A symbolized list of scopes.
      #
      def scopes
        return [] if @scopes.nil?

        @scopes.split(" ").map(&:to_sym)
      end

      ##
      # Checks if a specific scope has been granted by the user.
      #
      # @example
      #   @access_token.contains_scope?("user-read-top")
      #   @access_token.contains_scope?(:"user-read-top")
      #
      # @param [String,Symbol] scope The name of the scope you'd like to check. For example, "user-read-private".
      # @return [TrueClass,FalseClass] scope_included A true/false boolean if the scope is included.
      #
      def contains_scope?(scope)
        scopes.include?(scope.downcase.to_sym)
      end

      ##
      # When will the access token expire? Returns nil if no expires_in is defined.
      #
      # @example
      #   @session.expires_at
      #
      # @return [Time] time When the access token will expire.
      #
      def expires_at
        return nil if @expires_in.nil?

        Time.at(@expires_at)
      end

      ##
      # Check if the access token has expired. Returns nil if no expires_in is defined.
      #
      # @example
      #   @session.expired?
      #
      # @return [TrueClass,FalseClass,NilClass] has_expired Has the access token expired?
      #
      def expired?
        return nil if expires_at.nil?

        Time.now > expires_at
      end

      ##
      # Refresh the access token.
      #
      # @example
      #   @session.refresh!
      #
      # @return [TrueClass,FalseClass] success Have we been able to refresh the access token?
      #
      # rubocop:disable AbcSize
      def refresh!
        raise "You cannot refresh without a valid refresh_token." if @refresh_token.nil?

        params = {
          client_id:     @accounts.instance_variable_get(:@client_id),
          client_secret: @accounts.instance_variable_get(:@client_secret),
          grant_type:    "refresh_token",
          refresh_token: @refresh_token
        }
        request = HTTParty.post("https://accounts.spotify.com/api/token", body: params)
        response = request.parsed_response.with_indifferent_access

        @access_token = response[:access_token]
        @expires_in = response[:expires_in]
        @expires_at = response[:expires_in] + Time.now.to_i
        @scopes = response[:scope]

        true
      rescue HTTParty::Error
        false
      end
      # rubocop:enable AbcSize

      ##
      # Export to JSON. Designed mostly for iOS, Android, or external use cases.
      #
      # @example
      #   @session.to_json
      #
      # @return [String] json The JSON output of the session instance.
      #
      def to_json(*_args)
        {
          access_token:  @access_token.presence,
          expires_at:    @expires_at.presence,
          refresh_token: @refresh_token.presence,
          scopes:        scopes
        }.to_json
      end

      def inspect # :nodoc:
        "#<%s:0x00%x>" % [self.class.name, (object_id << 1)]
      end
    end
  end
end
