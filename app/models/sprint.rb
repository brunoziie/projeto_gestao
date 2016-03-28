class Sprint < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :project

  has_enumeration_for :status, with: ProgressSprintStatus, create_helpers: true
end
