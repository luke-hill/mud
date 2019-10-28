# frozen_string_literal: true

module MUD
  class Weapon
    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @weapon = OpenStruct.new(weapon(id))
    end

    def_delegators :@weapon,
                   :name,
                   :description,
                   :min_power,
                   :max_power

    private

    def weapon(id)
      weapon_yml[id] || raise(RuntimeError, "Weapon not found with ID: #{id}")
    end
  end
end
