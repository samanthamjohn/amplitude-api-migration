class AmplitudeContext
  attr_accessor :os_name, :os_version, :device_model, :device_manufacturer, :carrier, :device_id, :app_version
  def initialize(context_dictionary)
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
end


