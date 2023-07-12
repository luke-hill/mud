# frozen_string_literal: true

module SpecSupport
  class Enemy < MUD::Enemy
    private

    def enemy_yml
      load_yml('spec/support/fixtures/enemy.yml')
    end
  end
end
