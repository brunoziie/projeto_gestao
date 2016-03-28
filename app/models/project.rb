class Project < ActiveRecord::Base
  extend EnumerateIt


  has_enumeration_for :status, with: ProgressProjectStatus, create_helpers: true
end