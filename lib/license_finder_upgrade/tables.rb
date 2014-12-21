require 'sequel'
require LicenseFinderUpgrade::Platform.sqlite_load_path

module LicenseFinderUpgrade
  DB = Sequel.connect(Platform.sqlite_adapter + "://" + config.artifacts.database_uri)
end
