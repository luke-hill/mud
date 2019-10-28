# frozen_string_literal: true

module MUD
  class Potion
    include Helpers::Data
    extend Forwardable

    attr_accessor :type
    attr_reader :id

    def initialize(id)
      @id = id
      @potion = OpenStruct.new(potion)
    end

    def_delegators :@potion,
                   :name,
                   :use_message,
                   :description,
                   :value

    private

    def potion
      determine_type && assign_potion_data
    end

    def determine_type
      return self.type = :healing if healing_potion?
      return self.type = :mana if mana_potion?
      return self.type = :hp_bonus if hp_bonus_potion?

      self.type = :unknown
    end

    def healing_potion?
      !!healing_potion_yml[id]
    end

    def mana_potion?
      !!mana_potion_yml[id]
    end

    def hp_bonus_potion?
      !!hp_bonus_potion_yml[id]
    end

    def assign_potion_data
      case type
      when :healing;  then healing_potion_yml[id]
      when :mana;     then mana_potion_yml[id]
      when :hp_bonus; then hp_bonus_potion_yml[id]
      else            raise(RuntimeError, "Weapon not found with ID: #{id}")
      end
    end
  end
end
