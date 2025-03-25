class DailyProg < ApplicationRecord
  validates       :date, presence: true
  belongs_to      :goal
  has_many        :task_progs, dependent: :destroy

  before_create   :set_date
  after_create    :initialize_task_progs
  before_update   :set_completion_timestamps

  private

  def initialize_task_progs
    goal.tasks.each do |task|
      task_progs.create(task: task, completed: false, date: date)
    end
  end

  def set_date
    self.date ||= Date.current
  end

  def set_completion_timestamps
    return unless completed_changed?

    self.completed_at = completed? ? Time.current : nil
  end
end
