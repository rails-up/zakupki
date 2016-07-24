module GroupsHelper
  def toggle_group_button_text(group)
    current_user.groups.include?(group) ? 'group.leave': 'group.join'
  end
end
