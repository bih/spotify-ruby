# frozen_string_literal: true

require "spotify/sdk/base"
require "spotify/sdk/model"
require "spotify/sdk/connect"
require "spotify/sdk/connect/device"
require "spotify/sdk/connect/playback_state"
require "spotify/sdk/artist"

module Spotify
  ##
  # Spotify::SDK contains the complete Ruby DSL to interact with the Spotify Platform.
  #
  class SDK
    ##
    # Initialize the Spotify SDK object.
    #
    # @example
    #   # Example 1: Load it in from an access token value.
    #   @sdk = Spotify::SDK.new("access_token_here")
    #
    #   # Example 2: Load it in with values from your database.
    #   @sdk = Spotify::SDK.new({
    #     access_token: "access_token_here",
    #     expires_in: 3_000_000,
    #     refresh_token: "refresh_token_here"
    #   })
    #
    #   # Example 4: Load it in from an OAuth2::AccessToken object.
    #   @sdk = Spotify::SDK.new(@auth.auth_code.get_token("auth code"))
    #
    #   # Example 5: Load it from a query string or a fully qualified URL.
    #   @sdk = Spotify::SDK.new("https://localhost:8080/#token=...&expires_in=...")
    #   @sdk = Spotify::SDK.new("token=...&expires_in=...")
    #
    # @param [String, Hash, OAuth2::AccessToken] obj Any supported object which contains an access token. See examples.
    #
    def initialize(session)
      raise "Invalid Spotify::Accounts::Session object" unless session.instance_of?(Spotify::Accounts::Session)
      @session = session
      mount_sdk_components
    end

    attr_reader :session

    def inspect # :nodoc:
      "#<%s:0x00%x>" % [self.class.name, (object_id << 1)]
    end

    ##
    # This is where we mount new SDK components to the Spotify::SDK object.
    # Simply add a key (this is your identifier) with the value being the object.
    #
    # Notes:
    # - Make sure your SDK component is being loaded at the top of this page.
    # - You can name your identifier whatever you want:
    #   - This will be what people will use to call your code
    #   - For example: it would be the `connect` in `Spotify::SDK.new(@session).connect`
    # - We'll call .new on your class, providing one parameter being the instance of this SDK (aka self).
    # - Make sure to a test for it in spec/lib/spotify/sdk_spec.rb (see how we did it for others)
    #
    SDK_COMPONENTS = {
      connect: Spotify::SDK::Connect
    }.freeze

    attr_reader(*SDK_COMPONENTS.keys)

    private

    ##
    # This is where we map the SDK component classes to the SDK component vairables.
    #
    def mount_sdk_components # :nodoc:
      SDK_COMPONENTS.map do |key, klass|
        instance_variable_set "@#{key}".to_sym, klass.new(self)
      end
    end
  end
end
