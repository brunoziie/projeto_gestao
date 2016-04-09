class Activity < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :user
  belongs_to :sprint
  belongs_to :project

  has_many :historicals, dependent: :destroy

  has_enumeration_for :status, with: ProgressActivityStatus, create_helpers: true

  def start_activity
    self.update_attribute(:status, ProgressActivityStatus::DOING)
  end

  def finish_activity
    self.update_attribute(:status, ProgressActivityStatus::DONE)
  end

  def reset_activity
    self.update_attribute(:status, ProgressActivityStatus::WAITING)
  end
end

