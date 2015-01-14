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

