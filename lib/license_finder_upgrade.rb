require "license_finder_upgrade/version"
require 'yaml'

module LicenseFinderUpgrade
  def self.config
    @config ||= Configuration.ensure_default
  end
end


require 'license_finder_upgrade/platform'
require 'license_finder_upgrade/configuration'

require 'license_finder_upgrade/decisions'

require 'license_finder_upgrade/tables'
require 'license_finder_upgrade/tables/manual_approval'
require 'license_finder_upgrade/tables/dependency'

require 'license_finder_upgrade/to_decisions'
