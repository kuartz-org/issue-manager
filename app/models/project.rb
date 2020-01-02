class Project < ApplicationRecord
  has_many :registrations
  has_many :issues, dependent: :destroy
end
