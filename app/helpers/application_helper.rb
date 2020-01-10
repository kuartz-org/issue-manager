module ApplicationHelper
  def icon_for_action(action)
    case action
    when 'opened' then 'fa-plus-square text-primary'
    when 'edited' then 'fa-edit'
    when 'closed' then 'fa-times-square text-warning'
    when 'reopened' then 'fa-plus-square text-primary'
    end
  end
end
