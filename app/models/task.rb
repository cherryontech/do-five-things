class Task < ApplicationRecord
  has_one :progress
  has_one :user
  belongs_to :user
end
