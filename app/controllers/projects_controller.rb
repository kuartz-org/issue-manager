class ProjectsController < ApplicationController
  def index
    @projects = Project.joins(:registrations).where('registrations.user_id = ?', current_user.id)
  end

  def show
    @project = Project.find(params[:id])
  end
end
