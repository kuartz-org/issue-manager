class ProjectPresenter < BasePresenter
  def open_issues_count
    __getobj__.issues.where(status: 'open').count
  end

  def users_count
    __getobj__.users.count
  end
end
