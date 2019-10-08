module Player
  class Avalanche
    attr_accessor :weapon, :armor, :hp, :max_hp, :inventory, :accuracy, :gold
    attr_accessor :room, :rooms_visited

    def initialize
      @weapon = Items::Weapon::Knife.new
      @armor = Items::Armor::Vest.new
      @hp = 28
      @max_hp = hp
      @inventory = [Items::Potion::LesserPotion.new, Items::Potion::LesserPotion.new]
      @accuracy = 0.85
      @gold = 200
      @room = World::Room.new(1)
      @rooms_visited = [room]
    end

    def room_number
      room.number
    end

    def buy(item)
      return puts "I'm sorry we dont have that item for sale" unless room.list_of_items_for_sale.include?(item)
      if item == 'Lesser Healing Potion' && gold > 25
        inventory << Items::Potion::LesserPotion.new
        self.gold -= 25
        puts "You bought a #{item} for 25 gold"
      elsif item == 'Endurance Potion' && gold > 200
        inventory << Items::Potion::EndurancePotion.new
        self.gold -= 200
        puts "You bought a #{item} for 200 gold"
      else
        puts 'You do not have enough gold for that.'
      end
    end

    def room_numbers_visited
      rooms_visited.map(&:number)
    end

    def enemy_present?
      room.enemy_alive?
    end

    def all_gold_items
      room.floor.select { |item| item.name == 'Gold' }
    end

    def total_gold_on_floor
      all_gold_items.map(&:amount).sum
    end

    def pickup_gold
      amount = total_gold_on_floor
      @gold += amount
      item = room.item_object_on_floor('Gold')
      room.floor.delete(item)
      puts "You picked up #{amount} gold"
    end

    def pickup_item(name)
      item = room.item_object_on_floor(name)
      return puts 'Item is not on floor' if item.nil?

      inventory << item
      puts "You picked up the #{name}"
      room.floor.delete(item)
    end

    def use_potion
      return puts "You don't have any potions" if inventory.empty?

      inventory.first.use(self)
      inventory.delete_at(0)
    end

    def use_key
      puts 'You hear a click as you turn the key. The door slowly opens'
      inventory.delete(barracks_key)
    end

    def fight
      return puts 'There is no enemy present' if enemy.nil?
      @dmg_dealt = damage_dealt
      @dmg_taken = damage_taken
      enemy_hp_after_attacking
      if enemy_killed?
        room.enemy_death_message
      else
        new_hp_after_taking_hit
      end
    end

    def new_hp_after_taking_hit
      return puts "The #{enemy_name} swung at you with his #{enemy_weapon_name}, but missed" if enemy_missed? || @dmg_taken == 0

      puts "The #{enemy_name} hit you for #{@dmg_taken} damage"
      update_own_hp

      if dead?
        raise StandardError, 'You died!'
      else
        puts "DEBUG --> YOUR HP:#{hp}hp."
      end
    end

    def enemy_hp_after_attacking
      return puts "You tried to attack the #{enemy_name} with your #{weapon_name}... but missed" if you_missed? || @dmg_dealt == 0

      puts "You hit the #{enemy_name} with your #{weapon_name} for #{@dmg_dealt} damage"
      update_enemy_hp

      if enemy_killed?
        puts 'Enemy killed'
      else
        puts "DEBUG --> ENEMY HP:#{enemy_hp}hp."
      end
    end

    def north
      puts cannot_move_in_direction
    end

    def south
      puts cannot_move_in_direction
    end

    def east
      return puts cannot_move_in_direction if room_number == 9

      if room_number == 8
        if !key?
          return puts missing_key
        else
          use_key
        end
      end

      if enemy_present?
        puts cannot_leave_whilst_enemy_alive
      else
        @room = rooms_visited[room_number] ||= World::Room.new(room_number + 1)
        puts room.desc
      end
    end

    def west
      return cannot_move_in_direction if room.number == 1

      if enemy_present?
        puts cannot_leave_whilst_enemy_alive
      else
        @room = rooms_visited[room_number - 2] ||= World::Room.new(room_number - 1)
        puts room.desc
      end
    end

    def barracks_key
      inventory.detect { |item| item.name == 'Barracks Key' }
    end

    def key?
      !!barracks_key
    end

    def cannot_move_in_direction
      "You can't go in that direction. There is a wall in the way!"
    end

    def missing_key
      'You are missing the key to the door that is blocking your passage. There are faint markings underneath the keyhole\
       that closely resemble the insignia of the Barracks'
    end

    def cannot_leave_whilst_enemy_alive
      "You must kill the #{enemy_name} before leaving the room!"
    end

    def enemy_name
      enemy.name
    end

    def enemy_weapon_name
      enemy.weapon.name
    end

    def enemy_killed?
      enemy_hp <= 0
    end

    def damage_dealt
      dmg = attack_value - enemy_defence
      if dmg < 0
        0
      else
        dmg
      end
    end

    def damage_taken
      dmg = enemy_attack - defend_value
      if dmg < 0
        0
      else
        dmg
      end
    end

    def update_own_hp
      self.hp -= @dmg_taken
    end

    def dead?
      hp <= 0
    end

    def you_missed?
      rand > accuracy
    end

    def enemy_missed?
      rand > enemy.accuracy
    end

    def update_enemy_hp
      enemy.hp -= @dmg_dealt
    end

    def enemy_hp
      enemy.hp
    end

    def attack_value
      rand((weapon.atk_min)..(weapon.atk_max))
    end

    def enemy_defence
      enemy.defend_value
    end

    def enemy_attack
      enemy.attack_value
    end

    def defend_value
      rand(0..(armor.def))
    end
    
    def enemy
      room.enemy
    end

    def weapon_name
      weapon.name
    end
  end
end
