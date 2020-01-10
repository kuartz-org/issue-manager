class Issue < ApplicationRecord
  extend Enumerize

  has_many :issue_feeds, dependent: :destroy
  has_many :actions,  through: :issue_feeds, source: :feed, source_type: 'Action'
  has_many :comments, through: :issue_feeds, source: :feed, source_type: 'Comment'

  belongs_to :project

  before_create :set_default_status

  enumerize :status, in: [:open, :closed]

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
