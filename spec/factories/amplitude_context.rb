FactoryGirl.define do
  factory :context, class: AmplitudeContext do
    device_id "device_id"
    app_version "2.0.0"
    os_name "ios"
    os_version "8.0"
    device_model "ipad4,2"
    device_manufacturer "Apple"
    carrier "AT&T"

    skip_create

    initialize_with{ new(
    {
      "idForVendor" => device_id,
      "appVersion" => app_version,
      "osName" => os_name,
      "osVersion" => os_version,
      "deviceModel" => device_model,
      "deviceManufacturer" => device_manufacturer,
      "carrier" => carrier
    }
    ) }
  end
end
