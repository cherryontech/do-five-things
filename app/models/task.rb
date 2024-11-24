class Task < ApplicationRecord
  validates     :text, presence: true
  before_create :validate_task_limit
  after_create  :validate_task_create_date

  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  private

  def validate_task_create_date
    return unless created_at < Time.zone.now.beginning_of_day

    errors.add(:base, "Tasks cannot be created for past dates.")
  end

  def validate_task_limit
    return unless Task.today.count >= 5

    errors.add(:base, "There can be at most 5 tasks for the day")
  end
end
