class AddStartedDateToSprints < ActiveRecord::Migration
  def change
    add_column :sprints, :started_date, :date
  end
end
