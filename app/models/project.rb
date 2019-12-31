class Project < ApplicationRecord
  has_many :registrations
  has_many :issues
end
