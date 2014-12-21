require "spec_helper"

module LicenseFinderUpgrade
  describe ToDecisions do
    let(:txn) { {some: 'txn data'} }

    def from_config(config)
      described_class.new(
        config: Configuration.new(config),
        dependencies: Dependency,
        txn: txn
      ).decisions.decisions
    end

    def from_db
      described_class.new(
        config: Configuration.new({}),
        dependencies: Dependency,
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

    it "copies manually created dependencies from db" do
      Dependency.create(name: "system", version: "0.1.2")
      Dependency.create(name: "manual", added_manually: true, version: "0.1.2", licenses: ["lic1", "lic2"])
      decisions = from_db
      expect(decisions).to include [:add_package, 'manual', '0.1.2', txn]
      expect(decisions).to include [:license, 'manual', 'lic1', txn]
      expect(decisions).to include [:license, 'manual', 'lic2', txn]
      expect(decisions).not_to include [:add_package, 'system', '0.1.2', txn]
    end

    it "copies manually licensed dependencies from db" do
      Dependency.create(name: "system", licenses: ["lic1", "lic2"])
      Dependency.create(name: "manual", license_assigned_manually: true, licenses: ["lic1", "lic2"])
      decisions = from_db
      expect(decisions).to include [:license, 'manual', 'lic1', txn]
      expect(decisions).to include [:license, 'manual', 'lic2', txn]
      expect(decisions).not_to include [:license, 'system', 'lic1', txn]
    end

    it "copies manually approved licenses from db" do
      time = Time.new(10000)
      Dependency.create(name: "system")
      manual = Dependency.create(name: "manual")
      manual.manual_approval = ManualApproval.create(approver: "Someone", notes: "Some reason", updated_at: time)
      manual.save

      decisions = from_db
      expect(decisions).to include [:approve, 'manual', { who: "Someone", why: "Some reason", when: time }]
      expect(decisions).not_to include [:approve, 'system', anything]
    end
  end
end
