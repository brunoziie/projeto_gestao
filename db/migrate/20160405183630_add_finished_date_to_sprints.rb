class AddFinishedDateToSprints < ActiveRecord::Migration
  def change
    add_column :sprints, :finished_date, :date
  end
end
