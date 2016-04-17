module GroupsHelper
  class ToggleGroupButton
    attr_accessor :text, :parameter

    def initialize(joined)
      if joined
        @text = 'group.leave'
        @parameter = 'leave'
      else
        @text = 'group.join'
        @parameter = 'join'
      end
    end
  end

  def toggle_group_btn(group)
    btn = ToggleGroupButton.new(current_user.joined?(group))
    link_to(I18n.t(btn.text), toggle_group_path(group, toggle_group: btn.parameter),
            class: "waves-effect waves-light btn", method: :post)
  end
end
