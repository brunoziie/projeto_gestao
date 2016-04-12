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
      self.update_attributes(status: ProgressActivityStatus::DOING, init_time: DateTime.now)
    else
      false
    end
  end

  def finish_activity
    if self.sprint.doing?
      self.update_attributes(status: ProgressActivityStatus::DONE, finish_time: DateTime.now)
    else
      false
    end
  end

  def create_historical type, user
    Historical.create activity: self, historic_type: type, user: user
  end

  def reset_activity
    self.update_attribute(:status, ProgressActivityStatus::WAITING)
  end
end

