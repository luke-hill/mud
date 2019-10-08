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

    def update
      puts "Data to be seeded: #{options}"
      puts "Existing Data: #{data}"

      options.each do |key, value|
        data[key.to_s] = value
      end

      yml_file[id] = data
      puts "New UPDATED Data: #{data}"
    end

    def data
      @data ||= yml_file[id] || {}
    end

    def yml_file
      @yml_file ||= begin
        YAML.load_file(yml_file_location)
      rescue Errno::ENOENT
        puts "File does not exist @ #{yml_file_location}. Creating new blank YML file."
        File.open(yml_file_location, 'w+') {|f| f.write({}) }
        YAML.load_file(yml_file_location)
      end
    end

    def save
      File.write(yml_file_location, yml_file.to_yaml)
    end
  end
end
