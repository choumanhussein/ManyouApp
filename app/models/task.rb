class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :duedate, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum priority: { low: 0, medium: 1, high: 2 }
  paginates_per 8
  belongs_to :user, optional: true
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
end
