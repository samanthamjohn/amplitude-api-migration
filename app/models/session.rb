class Session
  attr_accessor :events
  def initialize(session)
    context = AmplitudeContext.new(session["context"] || {})

    batch = session["batch"] || []
    events = []
    batch.each do |event|
      event = AmplitudeEvent.new(event, context)
      events << event.as_dictionary if event.should_be_imported?
    end

    @events = events
  end

  def should_be_imported?
    events.present?
  end

end
