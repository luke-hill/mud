module Enemy
  class Goblin
    attr_reader :name, :desc, :weapon, :armor, :accuracy
    attr_accessor :hp

    def initialize
      @name = 'Goblin Archer'
      @desc = 'Concealing himself in the distance, the Goblin Archer uses his metronomic eyes to aid his accuracy'
      @weapon = Items::Weapon::SmallBow.new
      @armor = Items::Armor::Unarmored.new
      @hp = rand(35..42)
      @accuracy = 0.95
    end

    def attack_value
      rand((weapon.atk_min)..(weapon.atk_max))
    end

    def defend_value
      rand(0..(armor.def))
    end
  end
end
