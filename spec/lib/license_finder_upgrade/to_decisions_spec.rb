require "spec_helper"

module LicenseFinderUpgrade
  describe ToDecisions do
    it "copies project name from yaml"
    it "copies whitelist from yaml"
    it "copies ignored dependencies from yaml"
    it "copies ignored groups from yaml"
    it "copies manually created dependencies from db"
    it "copies manually licensed dependencies from db"
    it "copies manually approved licenses from db"
  end
end
