class Session
  attr_accessor :events
  def initialize(session)
    events = []
    batch = session["batch"]
    context = AmplitudeContext.new(session["context"])
    batch.each do |event|
      event = AmplitudeEvent.new(event, context)
      events << event.as_dictionary if allowed_event_types.include?(event)
    end

    @events = events
  end

  private

end
