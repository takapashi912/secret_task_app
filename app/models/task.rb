class Task < ApplicationRecord
  belongs_to :user
  belongs_to :question_template, optional: true
  has_one :secret_post, dependent: :destroy

  enum :status, { pending: 0, completed: 1, not_completed: 2 }

  attr_accessor :secret_content

  validates :title, presence: true, length: { maximum: 100 }
  validates :due_at, presence: true
  validates :secret_content, presence: true, on: :create

  scope :overdue,  -> { pending.where("due_at < ?", Time.current) }
end
