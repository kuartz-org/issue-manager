class ProjectsController < ApplicationController
  def index
    @projects_count = current_user.projects.count
    return redirect_to project_path(current_user.projects.first) if @projects_count == 1

    params[:filter] = ['with_open_issues', 'all'].include?(params[:filter]) ? params[:filter] : 'with_open_issues'
    @projects_with_open_issues_count = current_user.projects.includes(:issues).where(issues: { status: 'open' }).count

    if params[:filter] == 'with_open_issues'
      @projects = ProjectQuery.relation(current_user.projects.includes(:issues).where(issues: { status: 'open' }))
    else
      @projects = ProjectQuery.relation(current_user.projects)
    end

    @projects = ProjectPresenter.wrap(@projects)
  end

  def show
    @project = current_user.projects.find(params[:id])
    redirect_to project_issues_path(@project)
  end
end
