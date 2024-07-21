class Task < ApplicationRecord
  validates :name, presence: true
  before_create :validate_task_limit

  private

  def validate_task_limit
    if Task.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count >= 5
      errors.add(:base, "There can be at most 5 tasks for the day")
      throw :abort
    end
  end
end
