require 'json'

module LicenseFinderUpgrade
  class Dependency < Sequel::Model
    plugin :boolean_readers

    plugin :composition
    composition :licenses,
      composer: ->(d) do
        if d.license_names.nil?
          Set.new
        else
          JSON.parse(d.license_names).to_set
        end
      end,
      decomposer: ->(d) { self.license_names = licenses.to_json }

    one_to_one :manual_approval

    dataset_module do
      def added_manually
        where(added_manually: true)
      end

      def license_assigned_manually
        where(license_assigned_manually: true)
      end
    end
  end
end

