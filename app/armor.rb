# frozen_string_literal: true

module MUD
  class Armor
    attr_reader :id

    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @id = id
    end

    def_delegators :armor,
                   :name,
                   :description,
                   :defense

    private

    def armor
      @armor ||= OpenStruct.new(armor_data)
    end

    def armor_data
      armor_yml[id] || raise(RuntimeError, "Armor not found with ID: #{id}")
    end
  end
end
