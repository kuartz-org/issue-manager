class CreateRelatedActionService
  def initialize(params)
    @issue  = Issue.find(params[:issue_id])
    @user   = User.find(params[:user_id])
    @action = params[:action]
  end

  def call
    @issue.actions.create(
      title: @action,
      user: @user
    )
  end
end
