class IssuesController < ApplicationController
  before_action :set_project, only: [:index, :show, :new, :create, :edit, :update, :close]
  before_action :set_enriched_issue, only: [:show, :edit]
  before_action :set_issue, only: [:update, :close]

  def index
    @open_issues_count = @project.issues.where(status: 'open').count
    @closed_issues_count = @project.issues.where(status: 'closed').count
    @issues_count = @project.issues.count

    
    params[:status] = Issue.status.values.push('all').include?(params[:status]) ? params[:status] : 'open'
    
    @issues = @project.issues
    @issues = @issues.where(status: params[:status]) unless params[:status] == 'all'
    @issues = IssueQuery.relation(@issues).include_actions
    @issues = IssuePresenter.wrap(@issues)
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = @project.issues.new(issue_params)

    if @issue.save
      create_related_action(:opened)
      redirect_to project_issue_path(@project, @issue)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      create_related_action(:edited)
      redirect_to project_issue_path(@project, @issue)
    else
      render :edit
    end
  end

  def close
    @issue.close!
    create_related_action(:closed)
    redirect_to project_issue_path(@project, @issue)
  end

  private

  def create_related_action(action)
    @issue.actions.create(
      title: action,
      user: current_user
    )
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_enriched_issue
    @issue = IssueQuery.relation(@project.issues).include_actions.find(params[:id])
    @issue = IssuePresenter.new(@issue)
  end

  def set_issue
    @issue = @project.issues.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(
      :title,
      :description
    )
  end
end
