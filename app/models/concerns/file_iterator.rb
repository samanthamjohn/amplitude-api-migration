class FileIterator

  def base_url
    "/Users/samanthajohn/Downloads/production/2014/09/18/"
  end

  def import_files
    Dir.glob(base_url + "*.log.gz").each do |filename|
      importer = FileImporter.new(filename)
      puts filename
      importer.import
    end
  end
end
