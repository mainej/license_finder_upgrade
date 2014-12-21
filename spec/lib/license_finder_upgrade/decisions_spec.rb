require 'spec_helper'

module LicenseFinderUpgrade
  describe Decisions do
    let(:txn) { { who: "Someone", why: "Somereason", when: Time.now.getutc } }

    describe ".add_package" do
      it "adds to list of decisions" do
        decisions = subject.add_package("dep", "0.2.0", txn).decisions
        expect(decisions.first).to eq [:add_package, "dep", "0.2.0", txn]
      end
    end

    describe ".license" do
      it "adds to a list of decisions" do
        decisions = subject.license("dep", "MIT", txn).decisions
        expect(decisions.first).to eq [:license, "dep", "MIT", txn]
      end
    end

    describe ".approve" do
      it "adds to a list of decisions" do
        decisions = subject.approve("dep", txn).decisions
        expect(decisions.first).to eq [:approve, "dep", txn]
      end
    end

    describe ".whitelist" do
      it "adds to a list of decisions" do
        decisions = subject.whitelist("MIT", txn).decisions
        expect(decisions.first).to eq [:whitelist, "MIT", txn]
      end
    end

    describe ".ignore" do
      it "adds to a list of decisions" do
        decisions = subject.ignore("dep", txn).decisions
        expect(decisions.first).to eq [:ignore, "dep", txn]
      end
    end

    describe ".ignore_group" do
      it "adds to a list of decisions" do
        decisions = subject.ignore_group("development", txn).decisions
        expect(decisions.first).to eq [:ignore_group, "development", txn]
      end
    end

    describe ".name_project" do
      it "adds to a list of decisions" do
        decisions = subject.name_project("proj", txn).decisions
        expect(decisions.first).to eq [:name_project, "proj", txn]
      end
    end
  end
end
