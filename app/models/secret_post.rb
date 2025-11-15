class SecretPost < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :content, presence: true

  scope :published, -> {joins(:task).merge(Task.not_completed)}
end