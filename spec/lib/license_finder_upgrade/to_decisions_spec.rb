require "spec_helper"

module LicenseFinderUpgrade
  describe ToDecisions do
    let(:txn) { {some: 'txn data'} }

    def from_config(config)
      described_class.new(
        config: Configuration.new(config),
        txn: txn
      ).decisions.decisions
    end

    it "copies project name from yaml" do
      expect(from_config("project_name" => "proj")).to include [:name_project, "proj", txn]
    end

    it "copies whitelist from yaml" do
      decisions = from_config("whitelist" => ["lic1", "lic2"])
      expect(decisions).to include [:whitelist, "lic1", txn]
      expect(decisions).to include [:whitelist, "lic2", txn]
    end

    it "copies ignored dependencies from yaml" do
      decisions = from_config("ignore_dependencies" => ["dep1", "dep2"])
      expect(decisions).to include [:ignore, "dep1", txn]
      expect(decisions).to include [:ignore, "dep2", txn]
    end

    it "copies ignored groups from yaml" do
      decisions = from_config("ignore_groups" => ["grp1", "grp2"])
      expect(decisions).to include [:ignore_group, "grp1", txn]
      expect(decisions).to include [:ignore_group, "grp2", txn]
    end

    it "copies manually created dependencies from db"
    it "copies manually licensed dependencies from db"
    it "copies manually approved licenses from db"
  end
end
