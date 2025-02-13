class Task < ApplicationRecord
  # validates     :text, presence: true
  validates     :order, presence: true

  has_many      :task_progs, dependent: :destroy
  belongs_to    :goal

  def daily_task_prog
    task_progs.where(date: Date.current)&.first
  end
end
