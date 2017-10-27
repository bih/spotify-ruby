# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      ##
      # For each SDK Initialization type, we have a base class to inherit from.
      #
      class Base
        ##
        # Initiate a Spotify SDK Initialization Base class.
        # Note: You would not ever initiate this class, but rather inherit from it.
        # See /lib/spotify/sdk/initialization/query_string.rb as an example.
        #
        # @example
        #   Spotify::SDK::Initialization::Base.new("access_token")
        #
        # @param [Object] subject Any object that can be used to identify an access token.
        #
        def initialize(subject)
          @subject = subject
        end

        ##
        # Determine whether this initialization type is valid, and should be performed.
        #
        # @example
        #   instance = Spotify::SDK::Initialization::Base.new("access_token")
        #   instance.should_perform?
        #
        # @return [Boolean] A true or false answer as to whether to perform this initialization type.
        #
        def should_perform?
          false
        end

        ##
        # Perform the class to extract the authentication details needed for the SDK class to run.
        #
        # @example
        #   instance = Spotify::SDK::Initialization::Base.new("access_token")
        #   instance.perform if instance.should_perform?
        #
        # @return [Hash] A hash containing only access_token, expires_in and refresh_token.
        #
        def perform
          {
            access_token:  nil,
            expires_in:    nil,
            refresh_token: nil
          }
        end

        ##
        # The subject of the class. Usually what has been sent to Spotify::SDK.new() is the subject.
        #
        attr_reader :subject

        # TODO: Delete this when tests are written.
        # def sample_inputs
        #   nil
        # end

        # SAMPLE_TOKEN = """
        #   AQBjjlIYyEuyK2HuzqfA2ldj0B88d63KX2pgdOC0N4Pg4Iuw232M7gEgXjQS0Zdt3Y1r2J3G
        #   rCOf4fs1JndDbyGY_uaPWj5hpYE_dMS0G5ouJKLaapDT50EysfV3XdW6aQlbw51dYjgZU-Ce
        #   NCnj7bPsq4nXhZzbUkr0aTuR8MKEOXuW7-xaz1h8et-ZFYQDa788LTS08pLu--1waspBsmqh
        #   SxbOl0xG5QBQ0NnTbCn1SWi-T1B7J_6twmv7GWXsR9RqeBg_U5KcT6ciz85YFrkRQ6n47PpP
        #   HBfTFjmJxB91plroOOIZAE3fQ37-RDqdK7YzSw6gAm0
        # """.strip
      end
    end
  end
end
