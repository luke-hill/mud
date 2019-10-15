module World
  class Room
    attr_accessor :floor
    attr_reader :number

    def initialize(number)
      @number = number
      @floor = []
    end

    def shop_menu
      puts '-----------------------------------'
      puts '| Lesser Healing Potion | 25 gold |'
      puts '-----------------------------------'
      puts '|   Endurance Potion   | 200 gold |'
      puts '-----------------------------------'
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
  end
end
