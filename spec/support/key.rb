# frozen_string_literal: true

module SpecSupport
  class Key < MUD::Key
    private

    def key_yml
      load_yml('spec/support/fixtures/key.yml')
    end
  end
end
