class Session
  attr_accessor :events
  def initialize(session)
    events = []
    batch = session["batch"]
    context = AmplitudeContext.new(session["context"])
    batch.each do |event|
      event = AmplitudeEvent.new(event, context)
      events << event.as_dictionary
    end

    @events = events
  end

  private
  def allowed_event_types
    ["played_community_project", "launched_app", "upload_succeeded", "tapped_new_project", "downloaded_project", "pressed_see_code_levels_funnel", "rules_created", "community_project_flagged", "community_project_starred"]
  end

end
