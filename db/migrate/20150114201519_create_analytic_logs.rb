class CreateAnalyticLogs < ActiveRecord::Migration
  def change
    create_table :analytic_logs do |t|
      t.integer :sort_order
      t.string :s3_object_key

      t.timestamps
    end
  end
end
