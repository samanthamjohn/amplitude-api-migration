require 'zlib'

class Import
  attr_accessor :filename
  def initialize(filename)
    @filename = filename
  end

  def import
    data = JSON.parse(data_string)
    session_importer = SessionImporter.new(data["logs"])
    session_importer.make_api_requests
  end

  def data_string
    file = open(filename)
    gz = Zlib::GzipReader.new(file)
    data_string = gz.read
    file.close

    data_string
  end
end

class ImportFile
  attr_accessor :sessions, :filename
  def initialize(filename)
    @filename = filename
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
     "bdaa7081756b762776b996abfc8400fc"
  end

  def amplitude_curl_string(events)
    "curl --data 'api_key=#{api_key}' --data 'event=#{events.to_json}' https://api.amplitude.com/httpapi"
  end
end


