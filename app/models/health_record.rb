class HealthRecord < ApplicationRecord
  belongs_to :pet

  validates :walked, inclusion: { in: [true, false] }
  validates :morning_meal, inclusion: { in: [true, false] }
  validates :evening_meal, inclusion: { in: [true, false] }
  validates :note, presence: true, allow_blank: true
end
