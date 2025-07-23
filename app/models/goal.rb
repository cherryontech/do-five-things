class Goal < ApplicationRecord
  belongs_to :user

  has_many :tasks, dependent: :destroy
  has_many :daily_progs, dependent: :destroy

  validates :start_date, presence: true

  after_create :set_default_end_date
  after_create :initialize_tasks

  private

  def initialize_tasks
    5.times do |i|
      order = i + 1
      Task.create!(order: order, goal: self)
    end
  end

  def set_default_end_date
    self.end_date ||= start_date + 182.days
  end
end
