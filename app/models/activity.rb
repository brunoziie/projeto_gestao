class Activity < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :user
  belongs_to :sprint
  belongs_to :project

  has_many :historicals, dependent: :destroy

  has_enumeration_for :status, with: ProgressActivityStatus, create_helpers: true

  def start_activity
    if self.sprint.doing?
      self.update_attribute(:status, ProgressActivityStatus::DOING)
    else
      false
    end
  end

  def finish_activity
    if self.sprint.doing?
      self.update_attribute(:status, ProgressActivityStatus::DONE)
    else
      false
    end
  end

  def reset_activity
    self.update_attribute(:status, ProgressActivityStatus::WAITING)
  end
end

