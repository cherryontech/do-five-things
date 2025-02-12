class DailyProg < ApplicationRecord
  validates       :date, presence: true
  belongs_to      :goal
  has_many        :task_progs, dependent: :destroy

  before_create   :set_date
  after_create    :initialize_task_progs

  private

  def initialize_task_progs
    goal.tasks.each do |task|
      task_progs.create(task: task, completed: false)
    end
  end

  def set_date
    self.date ||= Date.current
  end
end
