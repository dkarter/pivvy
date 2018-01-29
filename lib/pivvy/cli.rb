# frozen_string_literal: true

module Pivvy
  # CLI for PivotalTracker
  class CLI < Thor
    desc 'projects', 'Selects a project for the current working directory'
    def projects
      choose do |menu|
        menu.prompt = 'Please choose a project for the current directory:'
        client.projects.each { |p| render_choice(menu, p) }
      end
    end

    desc 'stories', 'Displays all stories for a project'
    def stories
      project_id = ProjectConfig.new.project_id
      project = client.project(project_id)
      stories = project.stories.map do |story|
        { id: story.id, name: story.name }
      end
      say(stories.join("\n"))
    end

    desc 'search [text]', <<-DESC
    Displays all stories for a project matching the search string
    DESC
    def search(text)
      project_id = ProjectConfig.new.project_id
      project = client.project(project_id)
      project.stories(filter: text).each do |s|
        say "#{s.name} [##{s.id}]"
      end
    end

    desc 'story_id', 'gets the story id from selection'
    def story_id(selection)
      matches = selection.match(/\[#(\d+)\]/)
      say matches.captures[0]
    end

    desc 'local_token', <<-DESC
    Stores the Pivotal Tracker API token in #{ProjectConfig::FILENAME} for the
    current project
    DESC
    def local_token(token)
      ProjectConfig.new.token = token
      say('Saved.')
    end

    desc 'global_token', <<-DESC
    Stores the Pivotal Tracker API token in #{GlobalConfig::FILENAME} globally
    DESC
    def global_token(token)
      GlobalConfig.new.token = token
      say('Saved.')
    end

    private

    def render_choice(menu, proj)
      menu.choice(proj.name) do
        say("Chose #{proj.name} - ##{proj.id}")
        ProjectConfig.new.project_id = proj.id
        say('Settings saved.')
      end
    end

    def token
      ProjectConfig.new.token || GlobalConfig.new.token
    end

    def client
      TrackerApi::Client.new(token: token)
    end
  end
end
