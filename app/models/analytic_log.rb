class AnalyticLog < ActiveRecord::Base
  validates :s3_object_key, uniqueness: true

  def self.import_data_to_amplitude
    order("sort_order ASC").each do |analytic_log|
      analytic_log.delay(priority: analytic_log.sort_order).import_data_from_file
    end
  end

  def s3_object
    s3 = AWS::S3.new
    object = s3.buckets["hopscotchanalytics"].objects[s3_object_key]
  end

  def import_data_from_file
    session_importer = SessionImporter.new(data["logs"])
    session_importer.make_api_requests
  end

  def filename
    "tmp/#{s3_object_key.gsub("/", "_")}"
  end

  def data
    JSON.parse(data_string)
  end

  def data_string
    write_file_locally
    read_local_file_and_delete
  end

  def read_local_file_and_delete
    file = File.open(filename, "r")
    gz = Zlib::GzipReader.new(file)
    data = gz.read

    file.close
    File.delete(file)

    data
  end

  def write_file_locally
    File.open(filename, 'wb') do |file|
      s3_object.read do |chunk|
        file.write(chunk)
      end
    end
  end
end
