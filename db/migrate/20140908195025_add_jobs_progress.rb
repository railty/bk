class AddJobsProgress < ActiveRecord::Migration
  def change
    add_column :delayed_jobs, :progress, :integer
    add_column :delayed_jobs, :stage, :string
  end
end
