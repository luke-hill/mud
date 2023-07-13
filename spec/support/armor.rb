# frozen_string_literal: true

module SpecSupport
  class Armor < MUD::Armor
    private

    def key_yml
      load_yml('spec/support/fixtures/armor.yml')
    end
  end
end
