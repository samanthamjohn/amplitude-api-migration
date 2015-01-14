class AmplitudeContext
  attr_accessor :os_name, :os_version, :device_model, :device_manufacturer, :carrier, :device_id, :app_version
  def initialize(context_dictionary={})
    @os_name = context_dictionary["os"] || ""
    @os_version = context_dictionary["osVersion"] || ""
    @device_model = context_dictionary["deviceModel"] || ""
    @device_manufacturer = context_dictionary["deviceManufacturer"] || ""
    @app_version = context_dictionary["appVersion"] || ""
    @carrier = context_dictionary["carrier"] || ""
    @device_id = context_dictionary["idForVendor"] || ""
  end

  def as_dictionary
    {
      device_id: device_id,
      app_version: app_version,
      os_name: os_name,
      os_version: os_version,
      device_model: device_model,
      device_manufacturer: device_manufacturer,
      carrier: carrier
    }
  end

  def should_be_imported?
    allowed_app_versions.include?(app_version)
  end

  def allowed_app_versions
    ["2.0.0", "2.0.1", "2.1.0", "2.1.1", "2.2.0", "2.2.1", "2.3.0", "2.3.1",
     "2.4.0.3", "2.4.1", "2.5.0", "2.5.1", "2.6.0", "2.6.0.1", "2.7.0.2", "2.7.0.4"]
  end
end


