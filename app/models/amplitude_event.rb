class AmplitudeEvent
  attr_accessor :context, :time, :event_type

  def initialize(event_dictionary, context)
    @context = context
    begin
      @time = DateTime.parse(event_dictionary["timestamp"]).to_i
    rescue
      FailedImport.create(events: event_dictionary, error_string: "Timestamp error: #{event_dictionary["timestamp"]}")
    end
    @event_type = event_dictionary["event"]
  end

  def as_dictionary
    {
      time: time,
      event_type: event_type,
    }.merge(context.as_dictionary)
  end

  def should_be_imported?
    allowed_event_types.include?(event_type) && time.present?
  end

  def allowed_event_types
    [
      "added_second_block_walkthrough",
      "application_first_launch",
      "chose_starter_template",
      "community_project_flagged",
      "community_project_starred",
      "downloaded_project",
      "followed_other_user",
      "launched_app",
      "launched_app_from_push_notification",
      "played_community_project",
      "pressed_see_code_levels_funnel",
      "repeat_visitor",
      "rules_created",
      "upload_succeeded",
      "viewed_other_user_profile",
      "viewed_search",
      "viewed_stream"
    ]
  end

end
