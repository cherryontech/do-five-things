class TaskProg < ApplicationRecord
  belongs_to :daily_prog
  belongs_to :task

  before_update :set_completion_timestamps
  after_save    :set_daily_prog_completion, if: :saved_change_to_completed?

  private

  def set_daily_prog_completion
    daily_prog.completed = daily_prog.task_progs.reload.pluck(:completed).all?(true)
    daily_prog.save!
  end

  def set_completion_timestamps
    return unless completed_changed?

    self.completed_at = completed? ? Time.current : nil
  end
end
