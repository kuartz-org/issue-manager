class Comment < ApplicationRecord
  belongs_to :user
  has_many :issue_feeds, as: :feed

  has_rich_text :content
end
