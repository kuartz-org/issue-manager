class IssuePresenter < BasePresenter
  def last_edit_action
    __getobj__.actions.where(title: ['edited', 'closed']).order(:created_at).last
  end
  
  def feeds
    __getobj__.actions.where.not(title: 'opened').order(:created_at)
  end
  
  def create_action
    __getobj__.actions.where(title: 'opened').order(:created_at).first
  end
end
