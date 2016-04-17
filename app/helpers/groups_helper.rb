module GroupsHelper
  def toggle_group_btn(group)
    link_to(set_translation(group), toggle_group_path(group, toggle_group: set_param(group)),
            class: "waves-effect waves-light btn", method: :post)
  end

  def set_translation(group)
    current_user.joined?(group) ? t('group.leave') : t('group.join')
  end

  def set_param(group)
    current_user.joined?(group) ? 'leave' : 'join'
  end
end
