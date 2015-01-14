class FailedImport < ActiveRecord::Migration
  def change
    create_table :failed_imports do |t|
      t.hstore :events
      t.string :error_string
      t.timestamps
    end
  end
end
