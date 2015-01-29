desc "Import data from our server to amplitude"
task import_daily_data: :environment do
  s3 = AWS::S3.new
  bucket = s3.buckets["hopscotchanalytics"]

  index = 0

  (-1..1).each do |day|
    now = DateTime.now + day.days
    date = now.strftime("%Y/%m/%-d")
    bucket.objects.with_prefix("production/#{date}").each do |o|
      if o.key.match("log")
        AnalyticLog.create(sort_order: index, s3_object_key: o.key)
        index += 1
      end
    end
  end

  AnalyticLog.import_data_to_amplitude
end
