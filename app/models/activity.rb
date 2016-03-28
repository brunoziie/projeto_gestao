class Activity < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :user
  belongs_to :sprint
  belongs_to :project

  has_enumeration_for :status, with: ProgressActivityStatus, create_helpers: true
end

