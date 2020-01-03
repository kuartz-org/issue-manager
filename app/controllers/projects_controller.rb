class ProjectsController < ApplicationController
  def index
    params[:filter] = ['all'].include?(params[:filter]) ? params[:filter] : 'all'

    @projects_count = current_user.projects.count
    @projects = ProjectQuery.relation(current_user.projects).with_open_issues_count
    @projects = ProjectPresenter.wrap(@projects)
  end

  def show
    @project = current_user.projects.find(params[:id])
    redirect_to project_issues_path(@project)
  end
end
