module World
  class Room
    attr_accessor :floor, :enemy
    attr_reader :number, :desc, :type

    def initialize(number)
      @number = number
      @desc = room_description
      @floor = []
      @enemy = enemy_in_room
      @type = room_types
    end

    def room_types
      if number == 1
        'Shop'
      else
        'Outside'
      end
    end

    def shop?
      type == 'Shop'
    end

    def shop_menu
      return unless shop?
      puts 'Well hello there brave traveller. Have a look at our wares'
      sleep 0.5
      puts '-----------------------------------'
      puts '| Lesser Healing Potion | 25 gold |'
      puts '-----------------------------------'
      puts '|   Endurance Potion   | 200 gold |'
      puts '-----------------------------------'
    end

    def list_of_items_for_sale
      ['Lesser Healing Potion', 'Endurance Potion']
    end

    def enemy_death_message
      puts 'You slayed the Goblin. Well done! Now move onto the next room and try kill the next one'
      if number == 8 && no_key_on_floor?
        puts 'Well done, you have killed the last goblin, now time for their Master. The ORC!!!'
        sleep 0.25
        puts 'Before moving off, you notice a key drop from the Goblins lifeless corpse'
        floor << Items::BarracksKey.new
      end

      EnemyDrops::General.new(@enemy).drop
      @enemy = nil
      if boss_room?
        raise StandardError, 'You have completed V0.1 of Adventures of avaLancHe'
      end
    end

    def no_key_on_floor?
      item_object_on_floor('Barracks Key').nil?
    end

    def item_object_on_floor(name)
      floor.detect do |item|
        item.name.downcase == name.downcase
      end
    end

    def enemy_alive?
      if enemy.nil?
        false
      else
        enemy_hp > 0
      end
    end

    def enemy_hp
      enemy.hp
    end

    def enemy_in_room
      if starting_room?
        nil
      elsif boss_room?
        Enemy::Orc.new
      else
        Enemy::Goblin.new
      end
    end

    def starting_room?
      number == 1
    end

    def boss_room?
      number == 9
    end

    def room_description
      if starting_room?
        "This room is the staging area before your challenge against the dungeon. PS It's also a shop!"
      elsif boss_room?
        'The room is covered in blood, stained from the battles of past. The Orc sits in the corner, beckoning you forward'
      else
        'This room is one of many which leads you to the final boss! Make sure to kill the goblin before proceeding'
      end
    end
  end
end
