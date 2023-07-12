# frozen_string_literal: true

module SpecSupport
  module Factory
    def create(type, data)
      find_class(type).new(:no_op).tap do |model|
        model.instance_variable_set("@#{type}", OpenStruct.new(data))
      end
    end

    def create_null_enemy
      SpecSupport::Enemy.new('null_enemy')
    end

    private

    def find_class(type)
      "MUD::#{type.capitalize}".constantize
    end
  end
end
