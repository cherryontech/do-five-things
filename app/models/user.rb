class User < ApplicationRecord
  has_many :tasks
  has_many :goals
  has_many :progresses

  def incomplete_tasks
    tasks.where(created_at: Time.zone.today.beginning_of_day .. Time.zone.today.end_of_day).where(complete: false)
  end
end
