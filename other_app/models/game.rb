class Game
  attr_reader :player

  def initialize
    display_welcome_message
    @player = Player::Avalanche.new(weapon, armor, hp)
  end

  private

  def display_welcome_message
    unless development?
      sleep 0.5
      puts '............................................'
      sleep 0.5
      puts "Hello and Welcome to Adventures of avaLancHe! Current Version #{game_version}"
      sleep 0.75
      puts "Whilst you're here, let me give you the down-low. You're about to begin LevelOne"
      sleep 0.75
      puts 'LevelOne, sees you spawn in our village against Several Monsters and then the boss - The Orc!'
      sleep 0.5
      puts '............................................'
      set_difficulty
    end
  end

  def development?
    true
  end

  def set_difficulty
    print 'Select your difficulty, before beginning your quest! (A: Easy, B: Medium, C: Hard) ...'
    case gets.chomp
      when 'A', 'a'
        puts 'Easy Mode selected'
        @difficulty = :a
      when 'B', 'b'
        puts 'Medium Mode selected'
        @difficulty = :b
      when 'C', 'c'
        puts 'Hard mode selected. Be prepared!'
        @difficulty = :c
      else
        puts 'Input not recognised, will default to Easy'
        @difficulty = :a
    end
  end

  def hp
    hp_modes[mode]
  end

  def hp_modes
    {
      a: 28,
      b: 24,
      c: 19,
    }
  end

  def weapon
    weapon_modes[mode]
  end

  def weapon_modes
    {
      a: Items::Weapon::Knife.new,
      b: Items::Weapon::Knife.new,
      c: Items::Weapon::Fists.new,
    }
  end

  def armor
    armor_modes[mode]
  end

  def armor_modes
    {
      a: Items::Armor::Vest.new,
      b: Items::Armor::Unarmored.new,
      c: Items::Armor::Unarmored.new,
    }
  end

  def game_version
    '0.1.0'
  end

  def mode
    @difficulty || :a
  end
end
