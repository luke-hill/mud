# frozen_string_literal: true

module SpecSupport
  module Factory
    def create(type, data)
      find_class(type).new(:no_op).tap do |model|
        model.instance_variable_set("@#{type}", OpenStruct.new(data))
      end
    end

    private

    def find_class(type)
      "MUD::#{type.capitalize}".constantize
    end
  end
end
