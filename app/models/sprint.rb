class Sprint < ActiveRecord::Base
  extend EnumerateIt

  after_create :increment_number
  after_create :update_status_on_create

  belongs_to :project

  has_many :activities, dependent: :destroy

  has_enumeration_for :status, with: ProgressSprintStatus, create_helpers: true

  def start_sprint
    self.update_attributes(status: ProgressSprintStatus::DOING, started_date: Date.today)
  end

  def finish_sprint
    self.update_attributes(status: ProgressSprintStatus::FINISHED, finished_date: Date.today)
  end

  def late?
    if self.status == ProgressSprintStatus::SCHEDULED
      if self.init_date < Date.today
        true
      else
        false
      end
    elsif self.status == ProgressSprintStatus::FINISHED
      if self.end_date < self.finished_date
        true
      else
        false
      end
    else
      if self.end_date < Date.today || self.init_date < self.started_date
        true
      else
        false
      end
    end
  end

  def sprint_name
    "#{number} - #{description}"
  end

  def todo_activities
    self.activities.where(status: ProgressActivityStatus::WAITING)
  end

  def doing_activities
    self.activities.where(status: [ProgressActivityStatus::DOING, ProgressActivityStatus::PAUSED ])
  end

  def done_activities
    self.activities.where(status: ProgressActivityStatus::DONE)
  end

  def status_number
    "#{done_activities.count}/#{self.activities.count}, #{self.status_percent.to_i}%" if activities.present?
  end

  def status_percent
    done_activities.count.to_f / self.activities.count.to_f * 100
  end

  def calculate_time
    milli = 0

    self.activities.where(status: ProgressActivityStatus::DONE).each do |activity|
      milli += (activity.finished_date - activity.initiate_date) - (activity.paused_time)
    end

    pretty_time(milli)
  end

  def calculate_estimate_time
    minutes = 0
    self.activities.each do |activity|
      minutes += activity.estimate
    end

    pretty_time(minutes*60)
  end

private
  def hms(seconds, decimals = 0)
    int   = seconds.floor
    decs  = [decimals, 8].min
    hms   = [int / 3600, (int / 60) % 60, int % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
    hms  << (seconds - int).round(decs).to_s if decs > 0
    hms
  end

  def pretty_time seconds
    mm, ss = seconds.divmod(60)            #=> [4515, 21]
    hh, mm = mm.divmod(60)           #=> [75, 15]
    dd, hh = hh.divmod(24)           #=> [3, 3]
    "%d dia(s), %d hora(s), %d minuto(s) e %d segundo(s)" % [dd, hh, mm, ss]
  end

  def increment_number
    maximum = self.project.sprints.maximum(:number)
      maximum.nil? ? self.number = 1 : self.number = (maximum += 1)
    self.save
  end

  def update_status_on_create
    self.update_attribute(:status, ProgressSprintStatus::SCHEDULED)
  end
end
