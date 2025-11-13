class Task < ApplicationRecord
  belongs_to :user
  belongs_to :question_template, optional: true

  enum :status, { pending: 0, completed: 1, not_completed: 2 }

  validates :title, presence: true, length: { maximum: 100 }
  validates :due_at, presence: true

  scope :overdue,  -> { pending.where("due_at < ?", Time.current) }
end
