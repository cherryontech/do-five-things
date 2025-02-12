class TaskProg < ApplicationRecord
  belongs_to :daily_prog
  belongs_to :task

  before_update :set_completion_timestamps

  private

  def set_completion_timestamps
    return unless completed_changed?

    self.completed_at = completed? ? Time.current : nil
  end
end
