# frozen_string_literal: true

module SpecSupport
  class Enemy < MUD::Enemy
    attr_reader :id

    def initialize(id)
      @id = id
    end

    private

    def enemy_data
      @enemy_data ||= enemy_yml[id] || boss_yml[id] || raise("TEST - Enemy/Boss not found with ID: #{id}")
    end

    def enemy_yml
      load_yml('spec/support/fixtures/enemy.yml')
    end

    def load_yml(file_subdir)
      YAML.load_file("#{Dir.pwd}/#{file_subdir}")
    end
  end
end
