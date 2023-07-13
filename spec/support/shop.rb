# frozen_string_literal: true

module SpecSupport
  class Shop < MUD::Shop
    private

    def description_yml
      load_yml('spec/support/fixtures/description.yml')
    end
  end
end
