class CommentsController < ApplicationController
  def create
    @project = current_user.projects.find(params[:project_id])
    @issue = @project.issues.find(params[:issue_id])

    if params[:reopen].present?
      @issue.reopen!
      CreateRelatedActionService.new(issue_id: @issue.id, action: :reopened, user_id: current_user.id).call
      
    elsif params[:close].present?
      @issue.close!
      CreateRelatedActionService.new(issue_id: @issue.id, action: :closed, user_id: current_user.id).call
    end

    if @issue.comments.create(comment_params.merge(user: current_user))
      redirect_to project_issue_path(@project, @issue)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
