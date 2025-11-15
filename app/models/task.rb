class Task < ApplicationRecord
  belongs_to :user
  belongs_to :question_template, optional: true
  has_one :secret_post, dependent: :destroy

  enum :status, { pending: 0, completed: 1, not_completed: 2 }

  attr_accessor :secret_content

  validates :title, presence: true, length: { maximum: 100 }
  validates :due_at, presence: true
  validates :secret_content, presence: true, on: :create
  validate :due_at_cannot_be_in_the_past

  scope :overdue,  -> { pending.where("due_at < ?", Time.current) }

  def due_at_cannot_be_in_the_past
    return if due_at.blank?

    if due_at < Time.current
      errors.add(:due_at, "は現在時刻より後の時間を設定してください")
    end
  end
end
