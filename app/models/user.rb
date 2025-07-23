class User < ApplicationRecord
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP } # <-- validates that the email is in correct format, and that it is unique

  passwordless_with :email # <-- tells Passwordless which field stores the email address

  has_many :goals, dependent: :destroy

  def current_goal
    goals.order(created_at: :desc).first || create_default_goal
  end

  private

  def create_default_goal
    goals.create!(
      start_date: Date.current,
      end_date: Date.current + 182.days
    )
  end
end
