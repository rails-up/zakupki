module ApplicationHelper
  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def render_flash
    rendered = []
    flash.each do |type, messages|
      return create_msg messages if messages.is_a? String
      messages.each do |m|
        rendered << create_msg(m) unless m.blank?
      end
    end
    rendered.join(' ')
  end

  def create_msg(m)
    "Materialize.toast(\"#{m}\", 4000);"
  end
end
