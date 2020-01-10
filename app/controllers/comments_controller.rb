class CommentsController < ApplicationController
  def create
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.find(params[:issue_id])

    if params[:reopen].present?
      @issue.reopen!
      create_related_action(:reopened)
      
    elsif params[:close].present?
      @issue.close!
      create_related_action(:closed)
    end

    if @issue.comments.create(comment_params.merge(user: current_user))
      redirect_to project_issue_path(@project, @issue)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def create_related_action(action)
    @issue.actions.create(
      title: action,
      user: current_user
    )
  end
end
