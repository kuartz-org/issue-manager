class Project < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations
  has_many :issues, dependent: :destroy

  validates :title, presence: true
end
