require 'yaml'

module AdminPanel
  class Base
    attr_reader :options

    def self.seed(options)
      new(options).seed
    end

    def initialize(options)
      @options = options
    end

    def seed
      raise ArgumentError, 'Room ID not set' unless id

      update
      save
    end

    private

    def id
      @id ||= options.delete(:id)
    end
  end
end
