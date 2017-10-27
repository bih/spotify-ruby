# frozen_string_literal: true

module Spotify
  class SDK
    ##
    # For each SDK response object (i.e. Device), we have a Model class. We're using OpenStruct.
    #
    class Model < OpenStruct
      ##
      # Initialize a new Model instance.
      #
      # @param [Hash] hash The response payload.
      # @param [Spotify::SDK] parent The SDK object for context. 
      #
      def initialize(payload, parent)
        super(payload)
        @parent = parent if @parent
      end

      ##
      # A reference to Spotify::SDK::Connect, so we can also do stuff.
      #
      attr_reader :parent
    end
  end
end
