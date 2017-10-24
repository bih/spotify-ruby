# frozen_string_literal: true

module Spotify
  class SDK
    class Initialization
      class Base
        def initialize(subject)
          @subject = subject
        end

        def should_perform?
          false
        end

        def perform
          {
            access_token:  nil,
            expires_in:    nil,
            refresh_token: nil
          }
        end

        attr_accessor :subject

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
