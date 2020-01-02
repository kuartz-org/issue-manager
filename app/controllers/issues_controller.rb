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
    @issue = IssuePresenter.new(@issue)
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
    @issue = IssuePresenter.new(@issue)
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

  def set_enriched_issue
    @issue = IssueQuery.relation(@project.issues).include_actions.find(params[:id])
  end

  def set_issue
    @issue = IssueQuery.relation(@project.issues).include_actions.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(
      :title,
      :description
    )
  end
end
