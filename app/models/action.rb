class Action < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :issue

  enumerize :title, in: [:opened, :edited, :closed]

  validates :title, presence: true
end
