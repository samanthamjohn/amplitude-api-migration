class AnalyticLog < ActiveRecord::Base
  validates :s3_object_key, uniqueness: true

  def create_job

  end
end
