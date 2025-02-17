class Task < ApplicationRecord
  # validates     :text, presence: true
  validates     :order, presence: true

  has_many      :task_progs, dependent: :destroy
  has_one       :daily_task_prog, -> { where(date: Date.current) }, class_name: 'TaskProg'
  belongs_to    :goal

  delegate      :completed, :completed_at, to: :daily_task_prog

  after_save    :update_daily_task_prog

  def completed=(value)
    daily_task_prog.completed = value
  end

  def completed_at=(value)
    daily_task_prog.completed_at = value
  end

  private

  def update_daily_task_prog
    return unless daily_task_prog.present?

    daily_task_prog.save!
  end
end
