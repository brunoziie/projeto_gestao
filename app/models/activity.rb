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

  def pause_activity
    if self.sprint.doing? && self.status == ProgressActivityStatus::DOING
      self.update_attributes(status: ProgressActivityStatus::PAUSED)
    else
      false
    end
  end

  def restart_activity
    if self.sprint.doing? && self.status == ProgressActivityStatus::PAUSED
      self.update_attributes(status: ProgressActivityStatus::DOING)
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

  def paused_time
    paused = self.historicals.where(historic_type: HistoricalType::PAUSED).order(:created_at)
    restarted = self.historicals.where(historic_type: HistoricalType::RESTARTED).order(:created_at)

    time = 0
    i = 0
    while i < restarted.length do
      time += restarted[i].timetable - paused[i].timetable
      i += 1
    end

    time
  end

  def paused_time_to_doing
    if self.first_pause?
    # NÃO TEM UM CICLO DE PAUSA COMPLETO
      self.paused? ? self.historicals.find_by(historic_type: HistoricalType::PAUSED).timetable - self.initiate_date : 0
    else
      self.paused_time
    end
  end

  def first_pause?
    self.historicals.where(historic_type: HistoricalType::RESTARTED).blank?
  end

  def last_pause
    self.historicals.where(historic_type: HistoricalType::PAUSED).order(:created_at).last.timetable
  end
end

