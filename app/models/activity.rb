class Activity < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :user
  belongs_to :sprint
  belongs_to :project

  has_many :historicals, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, :description, :estimate, presence: true

  has_enumeration_for :status, with: ProgressActivityStatus, create_helpers: true

  def start_activity
    if self.sprint.doing?
      self.update_attributes(status: ProgressActivityStatus::DOING)
    else
      false
    end
  end

  def finish_activity
    if self.sprint.doing?
      self.update_attributes(status: ProgressActivityStatus::DONE)
    else
      false
    end
  end

  def create_historical type, user
    Historical.create activity: self, historic_type: type, user: user, timetable: DateTime.now
  end

  def reset_activity
    self.update_attribute(:status, ProgressActivityStatus::WAITING)
  end

  def initiate_date
    self.historicals.find_by(historic_type: HistoricalType::INITIATE).timetable if self.historicals.find_by(historic_type: HistoricalType::INITIATE)
  end

  def finished_date
    self.historicals.find_by(historic_type: HistoricalType::FINISHED).timetable if self.historicals.find_by(historic_type: HistoricalType::INITIATE)
  end
end

