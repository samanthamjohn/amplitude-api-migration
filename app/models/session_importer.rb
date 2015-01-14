class SessionImporter
  attr_accessor :sessions
  def initialize(sessions_dictionary)
    @sessions = []
    sessions_dictionary.each do |session_dictionary|
      session = Session.new(session_dictionary)
      @sessions << session
    end
  end

  def make_api_requests(slice_size=250)
    events.each_slice(slice_size) do |events|
      result = `#{amplitude_curl_string(events)}`
      if result != "success"
        FailedImport.create(events: events, error_string: result)
      end
    end
  end



  def events
    sessions.map(&:events).flatten
  end

  def api_key
     ENV["AMPLITUDE_API_KEY"]
  end

  def amplitude_curl_string(events)
    "curl --data 'api_key=#{api_key}' --data 'event=#{events.to_json}' https://api.amplitude.com/httpapi"
  end
end


