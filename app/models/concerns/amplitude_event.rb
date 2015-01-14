class AmplitudeEvent
  attr_accessor :context, :time, :event_type, :event_properties

  def initialize(event_dictionary, context)
    @context = context
    begin
      @time = DateTime.parse(event_dictionary["timestamp"]).to_i
    rescue
      FailedImport.create(events: event_dictionary, error_string: "Timestamp error: #{event_dictionary["timestamp"]}")
    end
    @event_type = event_dictionary["event"]
    @event_properties = {}
  end

  def as_dictionary
    {
      time: time,
      event_type: event_type,
      event_properties: event_properties
    }.merge(context.as_dictionary)
  end

end
