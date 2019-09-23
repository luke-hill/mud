module Enemy
  class Orc
    attr_reader :name, :desc, :weapon, :armor, :accuracy
    attr_accessor :hp

    def initialize
      @name = 'Orc'
      @desc = orc_description
      @weapon = Items::Weapon::OrcDagger.new
      @armor = Items::Armor::OrcShield.new
      @hp = 100
      @accuracy = 0.9
    end

    def attack_value
      rand((weapon.atk_min)..(weapon.atk_max))
    end

    def defend_value
      rand(0..(armor.def))
    end

    private

    def orc_description
      'The Orc stands at over 8 feet tall. His Dagger that he is wielding is dripping with blood from its latest victim'
    end
  end
end
