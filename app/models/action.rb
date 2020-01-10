class Action < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :issue_feeds, as: :feed

  enumerize :title, in: [:opened, :edited, :closed, :reopened]

  validates :title, presence: true
end
