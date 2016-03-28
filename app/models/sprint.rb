class Sprint < ActiveRecord::Base
  extend EnumerateIt

  has_enumeration_for :status, with: ProgressSprintStatus, create_helpers: true
end
