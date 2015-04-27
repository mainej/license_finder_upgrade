require "delegate"
require "pathname"

module LicenseFinderUpgrade
  class Configuration
    def self.ensure_default
      prepare(Persistence.get)
    end

    # It's nice to keep destructive file system manipulation out of the
    # initializer.  That reduces test polution, but is slightly inconvenient
    # for methods like Configuration.ensure_default and Configuration.move!,
    # which need a working artifacts directory. This helper is a compromise.
    def self.prepare(config)
      result = new(config)
      result.artifacts.init
      result
    end

    attr_accessor :whitelist, :ignore_groups, :ignore_dependencies, :artifacts, :project_name, :gradle_command

    def initialize(config)
      @whitelist     = Array(config['whitelist'])
      @ignore_groups = Array(config["ignore_groups"])
      @ignore_dependencies = Array(config["ignore_dependencies"])
      @artifacts     = Artifacts.new(Pathname(config['dependencies_file_dir'] || './doc/'))
      @project_name  = config['project_name'] || determine_project_name
      @gradle_command = config['gradle_command'] || 'gradle'
    end

    def save!
      hash = to_hash
      if hash.empty?
        Persistence.delete
      else
        Persistence.set(hash)
      end
    end

    def to_hash
      result = {}
      if gradle_command != "gradle"
        result['gradle_command'] = gradle_command
      end
      if artifacts.decisions_file.cleanpath != Pathname.new("doc/dependency_decisions.yml").cleanpath
        result['decisions_file'] = artifacts.decisions_file.to_s
      end
      result
    end

    def determine_project_name
      Pathname.pwd.basename.to_s
    end

    class Artifacts < SimpleDelegator
      def init
        mkpath
      end

      def database_uri
        URI.escape(database_file.expand_path.to_s)
      end

      def decisions_file
        join("dependency_decisions.yml")
      end

      private

      def database_file
        join("dependencies.db")
      end
    end

    module Persistence
      extend self

      def get
        YAML.load(file.read)
      end

      def set(hash)
        file.open('w') { |f| f.write(YAML.dump(hash)) }
      end

      def delete
        file.unlink
      end

      private

      def file
        Pathname.new('.').join('config', 'license_finder.yml')
      end
    end
  end
end
