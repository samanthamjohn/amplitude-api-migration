# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
s3 = AWS::S3.new
bucket = s3.buckets["hopscotchanalytics"]

index = 0
bucket.objects.with_prefix("production").each do |o|
  if o.key.match("log")
    AnalyticLog.create(sort_order: index, s3_object_key: o.key)
    index += 1
  end
end
