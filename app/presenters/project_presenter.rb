class ProjectPresenter < BasePresenter
  def open_issues_count
    __getobj__.issues.where(status: 'open').count
  end
end
