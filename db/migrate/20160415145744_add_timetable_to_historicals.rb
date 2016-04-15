class AddTimetableToHistoricals < ActiveRecord::Migration
  def change
    add_column :historicals, :timetable, :datetime
  end
end
