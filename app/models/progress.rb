class Progress < ApplicationRecord
  # daily progress - all tasks completed
  belongs_to :user
  has_many :tasks

end
