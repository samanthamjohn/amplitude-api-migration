FactoryGirl.define do
  factory :event, class: AmplitudeEvent do
    event_type "viewed_stream"
    time { Time.now }
    context context
  end
end
