class ProjectPresenter < BasePresenter
  def open_issues_count
    __getobj__.open_issues_count
  end

  def users_count
    __getobj__.users.count
  end
end
