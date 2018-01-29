# frozen_string_literal: true

module Pivvy
  # Manages configuration for a project directory
  class ProjectConfig
    FILENAME = '.pivvyrc.yml'

    def initialize
      @config = YAML.load_file(FILENAME)
    rescue Errno::ENOENT
      @config = {}
    end

    def project_id
      config['project_id']
    end

    def project_id=(id)
      config['project_id'] = id
      save
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
      File.open(FILENAME, 'w') { |f| f.write(config.to_yaml) }
    end
  end
end
