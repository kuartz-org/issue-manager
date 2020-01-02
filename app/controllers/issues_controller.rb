class IssuesController < ApplicationController
  before_action :set_project, only: [:index, :show, :new, :create, :edit, :update, :close]
  before_action :set_issue, only: [:show, :edit, :update, :close]
  before_action :set_actions, only: [:show, :edit]

  def index
    @open_issues_count = @project.issues.where(status: 'open').count
    @closed_issues_count = @project.issues.where(status: 'closed').count
    @issues_count = @project.issues.count
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = @project.issues.new(issue_params)

    if @issue.save
      @issue.actions.create!(
        title: :opened,
        user: current_user
      )

      redirect_to project_issue_path(@project, @issue)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      @issue.actions.create(
        title: :edited,
        user: current_user
      )
      redirect_to project_issue_path(@project, @issue)
    else
      render :edit
    end
  end

  def close
    @issue.close!
    @issue.actions.create(
      title: :closed,
      user: current_user
    )
    redirect_to project_issue_path(@project, @issue)
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_issue
    @issue = @project.issues.includes(actions: :user).find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(
      :title,
      :description
    )
  end

  def set_actions
    @actions = @issue.actions.includes(:user).order(:created_at)
    @create_action = @actions.first
    @last_edit_action = @actions.where(title: 'edited').last
    @actions = @actions.where.not(title: 'opened')
  end
end
