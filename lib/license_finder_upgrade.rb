require "license_finder_upgrade/version"

module LicenseFinderUpgrade
  ROOT_PATH = Pathname.new(__FILE__).dirname
  autoload :Configuration, 'license_finder_upgrade/configuration'
  autoload :Decisions,     'license_finder_upgrade/decisions'

  autoload :DB,             'license_finder_upgrade/tables'
  autoload :ManualApproval, 'license_finder_upgrade/tables/manual_approval'
  autoload :Dependency,     'license_finder_upgrade/tables/dependency'

  autoload :ToDecisions, 'license_finder_upgrade/to_decisions'

  def self.config
    @config ||= Configuration.ensure_default
  end
end
