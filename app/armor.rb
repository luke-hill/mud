# frozen_string_literal: true

module MUD
  class Armor
    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @armor = OpenStruct.new(armor(id))
    end

    def_delegators :@armor,
                   :name,
                   :description,
                   :defense

    private

    def armor(id)
      armor_yml[id] || raise(RuntimeError, "Armor not found with ID: #{id}")
    end
  end
end
