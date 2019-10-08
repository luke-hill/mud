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
      raise ArgumentError, 'ID not set' unless id

      update
      save
    end

    private

    def id
      @id ||= options.delete(:id)
    end

    def save
      File.write(yml_file_location, yml_file.to_yaml)
    end

    def yml_file
      @yml_file ||= YAML.load_file(yml_file_location)
    end
  end
end
