require 'rubygems'
require 'bundler/setup'

require 'license_finder_upgrade'
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec

  config.around do |example|
    LicenseFinderUpgrade::DB.transaction(rollback: :always) { example.run }
  end
end
