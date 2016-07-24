module AcceptanceHelper
  def fill_in_ckeditor(locator, opts)
    content = opts.fetch(:with).to_json
    page.execute_script <<-SCRIPT
    CKEDITOR.instances['#{locator}'].setData(#{content});
    $('textarea##{locator}').text(#{content});
    SCRIPT
  end
end
