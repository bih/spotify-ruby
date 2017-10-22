# frozen_string_literal: true

module Spotify
  class SDK
    class Connect
      class Device
        def initialize(raw_data)
          @raw_data = raw_data
        end

        def respond_to_missing?(_method_name, _include_private=false)
          true
        end

        def method_missing(meth, *_args, &_block)
          column = @raw_data[meth]
          column.present? ? column : super
        end
      end
    end
  end
end
