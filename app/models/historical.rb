class Historical < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :activity
  belongs_to :user

  has_enumeration_for :type, with: HistoricalType, create_helpers: true
end

