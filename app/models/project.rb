class Project < ActiveRecord::Base
  extend EnumerateIt

  has_enumeration_for :status, with: ProgressProjectStatus, create_helpers: true

  validates :name, :description, presence: true

  has_many :sprints, dependent: :destroy
  has_many :activities, dependent: :destroy

  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  def backlog_activities
    activities.where(sprint: nil)
  end

  def free_users
    (User.all) - self.users
  end
end
