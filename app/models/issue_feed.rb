class IssueFeed < ApplicationRecord
  belongs_to :feed, polymorphic: true
  belongs_to :issue
end
