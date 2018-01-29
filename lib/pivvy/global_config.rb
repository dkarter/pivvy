# frozen_string_literal: true

module Pivvy
  # Manages configuration for a project directory
  class GlobalConfig
    FILENAME = '~/.config/pivvy/pivvyrc.yml'

    def initialize
      @config = YAML.load_file(FILENAME)
    rescue Errno::ENOENT
      @config = {}
    end

    def token
      config['token']
    end

    def token=(id)
      config['token'] = id
      save
    end

    private

    attr_reader :config

    def save
      expanded = File.expand_path(FILENAME)
      dir = File.dirname(expanded)
      FileUtils.mkdir_p(dir)
      File.open(expanded, 'w') { |f| f.write(config.to_yaml) }
    end
  end
end
