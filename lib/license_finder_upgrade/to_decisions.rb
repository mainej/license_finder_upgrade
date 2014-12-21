module LicenseFinderUpgrade
  class ToDecisions
    def self.default_txn
      {
        who: "license_finder_upgrade script",
        why: "Upgrading from license_finder 1.2 to 2.0",
        when: Time.now.getutc
      }
    end

    def self.upgrade
      new(config: LicenseFinderUpgrade.config, dependencies: Dependency).decisions.save!
    end

    def initialize(options)
      @config = options.fetch(:config)
      @dependencies = options.fetch(:dependencies)
      @txn = options.fetch(:txn) { self.class.default_txn }
      @decisions = Decisions.new
      prepare
    end

    attr_reader :decisions

    private

    def prepare
      @decisions.name_project(@config.project_name, @txn)
      @config.whitelist.each do |license|
        @decisions.whitelist(license, @txn)
      end
      @config.ignore_dependencies.each do |dep|
        @decisions.ignore(dep, @txn)
      end
      @config.ignore_groups.each do |group|
        @decisions.ignore_group(group, @txn)
      end
      @dependencies.added_manually.each do |dep|
        @decisions.add_package(dep.name, dep.version, @txn)
        prepare_licenses(dep)
      end
      @dependencies.license_assigned_manually.each do |dep|
        prepare_licenses(dep)
      end
      @dependencies.each do |dep|
        if approval = dep.manual_approval
          txn = {
            who: approval.approver,
            why: approval.notes,
            when: approval.safe_created_at
          }
          @decisions.approve(dep.name, txn)
        end
      end
    end

    def prepare_licenses(dep)
      dep.licenses.each do |license|
        @decisions.license(dep.name, license, @txn)
      end
    end
  end
end
