module Enemy
  class Goblin
    attr_reader :name, :desc, :weapon, :armor, :accuracy
    attr_accessor :hp

    def initialize
      @name = 'Goblin'
      @desc = goblin_description
      @weapon = Items::Weapon::GoblinAxe.new
      @armor = Items::Armor::Unarmored.new
      @hp = rand(5..13)
      @accuracy = 0.7
    end

    def attack_value
      rand((weapon.atk_min)..(weapon.atk_max))
    end

    def defend_value
      rand(0..(armor.def))
    end

    private

    def goblin_description
      "A Hideous creature, borne out of pure evil! Luckily this one is just an infant, so shouldn't pose much threat"
    end
  end
end
