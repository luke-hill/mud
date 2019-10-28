module SpecSupport
  module Enemy
    def create(data)
      MUD::Enemy.new('no_enemy').tap do |enemy|
        enemy.instance_variable_set(:@enemy, OpenStruct.new(data))
      end
    end
  end
end
