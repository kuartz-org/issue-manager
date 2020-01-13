class Issue < ApplicationRecord
  extend Enumerize
  
  belongs_to :project
  has_many :issue_feeds, dependent: :destroy
  has_many :actions,  through: :issue_feeds, source: :feed, source_type: 'Action'
  has_many :comments, through: :issue_feeds, source: :feed, source_type: 'Comment'

  enumerize :status,   in: [:open, :closed]
  enumerize :category, in: [:bug, :new_feature]

  before_create :set_default_status

  validates :title, presence: true

  has_rich_text :description

  def closed?
    status == 'closed'
  end

  def close!
    update(
      status: 'closed',
      closed_at: Time.now
    )
  end

  def reopen!
    update(
      status: 'open',
      closed_at: nil
    )
  end

  def set_default_status
    self.status = 'open'
  end
end
