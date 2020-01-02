class Issue < ApplicationRecord
  extend Enumerize

  has_many :actions, dependent: :destroy
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

  def set_default_status
    self.status = 'open'
  end
end
