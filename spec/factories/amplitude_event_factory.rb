FactoryGirl.define do
  factory :amplitude_event do
    event_type "viewed_stream"
    time { Time.now }
    context
  end
end
