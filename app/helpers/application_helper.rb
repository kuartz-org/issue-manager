module ApplicationHelper
  def icon_for_action(action)
    case action
    when 'opened' then 'fa-plus-square'
    when 'edited' then 'fa-edit'
    when 'closed' then 'fa-times-square'
    end
  end
end
