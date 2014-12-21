module LicenseFinderUpgrade
  class Decisions
    #######
    # WRITE
    #######

    attr_reader :decisions

    def initialize
      @decisions = []
    end

    def add_package(name, version, txn = {})
      @decisions << [:add_package, name, version, txn]
      self
    end

    def license(name, lic, txn = {})
      @decisions << [:license, name, lic, txn]
      self
    end

    def approve(name, txn = {})
      @decisions << [:approve, name, txn]
      self
    end

    def whitelist(lic, txn = {})
      @decisions << [:whitelist, lic, txn]
      self
    end

    def ignore(name, txn = {})
      @decisions << [:ignore, name, txn]
      self
    end

    def ignore_group(name, txn = {})
      @decisions << [:ignore_group, name, txn]
      self
    end

    def name_project(name, txn = {})
      @decisions << [:name_project, name, txn]
      self
    end

    #########
    # PERSIST
    #########

    def save!
      write!(persist)
    end

    def persist
      YAML.dump(@decisions)
    end

    def write!(value)
      LicenseFinderUpgrade.config.artifacts.decisions_file.open('w+') do |f|
        f.print value
      end
    end
  end
end
