# frozen_string_literal: true

module MUD
  class Weapon
    attr_reader :id

    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @id = id
    end

    def_delegators :weapon,
                   :name,
                   :description,
                   :min_power,
                   :max_power

    private

    def weapon
      @weapon ||= OpenStruct.new(weapon_data)
    end

    def weapon_data
      weapon_yml[id] || raise(RuntimeError, "Weapon not found with ID: #{id}")
    end
  end
end
