# frozen_string_literal: true

module Spotify
  class SDK
    ##
    # Spotify::SDK::Initialization deals with parsing input for the
    # following code block `Spotify::SDK.new(input)` and extracting
    # the access token, expiry and refresh token.
    #
    # You'll never have to interact with this, unless you have other
    # objects you want us to parse the aforementioned variables from.
    #
    class Initialization
      ##
      # This is where you mount new Initialization objects.
      # Don't worry, we prefix Spotify::SDK::Initialization for you.
      #
      # @see /lib/spotify/sdk/initialization/url_string.rb
      #
      CLASSES = %i[
        OAuthAccessToken
        QueryString
        URLString
        PlainString
        QueryHash
      ].freeze

      class << self
        ##
        # Initiate a new Spotify SDK Initialization object
        #
        # @example
        #   begin
        #     hash = Spotify::SDK::Initialization.detect("access_token")
        #     puts "Access Token: #{hash[:access_token]}"
        #     puts "Expires in: #{hash[:expires_in]}"
        #     puts "Refresh Token: #{hash[:refresh_token]}"
        #   rescue Spotify::Errors::InitializationObjectInvalidError => e
        #     puts "Can't recognise the input because: #{e.inspect}"
        #   end
        #
        # @param [String,Hash,OAuth2::AccessToken] subject An instance of Spotify::SDK as a reference point.
        #
        def detect(subject)
          klasses = CLASSES.map do |klass_name|
            ("Spotify::SDK::Initialization::%s" % klass_name).constantize.new(subject)
          end

          matches = klasses.select(&:should_perform?)

          case matches.size
          when 1
            matches.first.perform
          when 0
            raise Spotify::Errors::InitializationObjectInvalidError
          else
            raise Spotify::Errors::InitializationObjectDuplicationError
          end
        end
      end
    end
  end

  class Errors
    ##
    # A Error class for when the initialization subjectect is not valid (see `initialize(subject)` for more info).
    #
    class InitializationObjectInvalidError < StandardError; end

    ##
    # A Error class for when the initialization subjectect matches against multiple selectors.
    # When this Error occurs, this becomes an internal bug. It should be filed on the GitHub issue tracker.
    #
    class InitializationObjectDuplicationError < StandardError; end
  end
end
