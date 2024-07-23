class Task < ApplicationRecord
  validates :name, presence: true
  before_create :validate_task_limit
  before_save   :validate_task_create_date

  private

  def validate_task_create_date
    if created_at < Time.zone.now.beginning_of_day
      errors.add(:base, "Tasks cannot be edited for past dates.")
      throw :abort
    end
  end

  def validate_task_limit
    if Task.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count >= 5
      errors.add(:base, "There can be at most 5 tasks for the day")
      throw :abort
    end
  end
end
