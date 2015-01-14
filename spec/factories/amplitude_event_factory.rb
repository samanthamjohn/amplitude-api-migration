FactoryGirl.define do
  factory :event, class: AmplitudeEvent do

    event_type "viewed_stream"
    time { Time.now }
    context

    skip_create
    initialize_with{ new( {"timestamp" => time.to_s, "event" => event_type}, context )}
  end
end
