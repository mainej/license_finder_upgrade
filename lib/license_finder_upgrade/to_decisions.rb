module LicenseFinderUpgrade
  class ToDecisions
    def self.default_txn
      {
        who: "license_finder_upgrade",
        why: "Upgrading from license_finder 0.8",
        when: Time.now.getutc
      }
    end

    def initialize(options)
      @config = options.fetch(:config)
      @dependencies = options.fetch(:dependencies)
      @txn = options.fetch(:txn) { default_txn }
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
      end
      @dependencies.license_assigned_manually.each do |dep|
        dep.licenses.each do |license|
          @decisions.license(dep.name, license, @txn)
        end
      end
      @dependencies.each do |dep|
        if dep.manual_approval
          txn = {
            who: dep.manual_approval.approver,
            why: dep.manual_approval.notes,
            when: dep.manual_approval.updated_at
          }
          @decisions.approve(dep.name, txn)
        end
      end
    end

  end
end
