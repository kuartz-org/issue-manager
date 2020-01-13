class IssuesController < ApplicationController
  before_action :set_project
  before_action :set_enriched_issue, only: [:show, :edit]
  before_action :set_issue, only: [:update, :reopen, :close]

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
    @comment = Comment.new
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = @project.issues.new(issue_params)

    if @issue.save
      CreateRelatedActionService.new(issue_id: @issue.id, action: :opened, user_id: current_user.id).call
      redirect_to project_issue_path(@project, @issue)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.new
  end

  def update
    if @issue.update(issue_params)
      CreateRelatedActionService.new(issue_id: @issue.id, action: :edited, user_id: current_user.id).call
      redirect_to project_issue_path(@project, @issue)
    else
      render :edit
    end
  end

  def reopen
    @issue.reopen!
    CreateRelatedActionService.new(issue_id: @issue.id, action: :reopened, user_id: current_user.id).call
    redirect_to project_issue_path(@project, @issue)
  end

  def close
    @issue.close!
    CreateRelatedActionService.new(issue_id: @issue.id, action: :closed, user_id: current_user.id).call
    redirect_to project_issue_path(@project, @issue)
  end

  private

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
