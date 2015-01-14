class AddSuccessWhenLogUploadsSuccessfully < ActiveRecord::Migration
  def change
    add_column :analytic_logs, :successful_import, :boolean, default: false
  end
end
