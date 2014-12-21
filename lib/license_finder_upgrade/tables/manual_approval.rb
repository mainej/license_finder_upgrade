module LicenseFinderUpgrade
  class ManualApproval < Sequel::Model
    def safe_created_at
      created_at.is_a?(String) ?
        Time.parse(created_at) :
        created_at
    end
  end
end
