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
      # @example
      #   module Spotify
      #     class SDK
      #       class User < Model
      #       end
      #     end
      #   end
      #
      #   @base = Spotify::SDK::Base.new(@sdk)
      #   @user = Spotify::SDK::User.new({ username: "hi" }, @base)
      #   @user.username # => "hi"
      #
      # @param [Hash] hash The response payload.
      # @param [Spotify::SDK] parent The SDK object for context.
      #
      def initialize(payload, parent)
        @payload = payload
        raise "Expected payload to be of Hash type" unless @payload.instance_of?(Hash)

        @parent = parent
        raise "Expected parent to be of Spotify::SDK::Base type" unless @parent.is_a?(Spotify::SDK::Base)

        super(payload)
      end

      def to_h # :nodoc:
        super.to_h.except(:parent)
      end

      ##
      # A reference to Spotify::SDK::Connect.
      #
      attr_reader :parent

      class << self
        def alias_attribute(new_method, attribute) # :nodoc:
          if attribute.is_a?(Symbol)
            define_method(new_method) { send(attribute) }
          else
            define_method(new_method) do
              self.class.hash_selector(to_h, attribute)
            end
          end
        end

        def hash_selector(hash, selector)
          hash.deep_symbolize_keys!
          segments = selector.split(".")
          hash = hash[segments.shift.try(:to_sym)] while segments.any?
          hash
        end
      end
    end
  end
end
