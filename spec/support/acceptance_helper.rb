module AcceptanceHelper

  def materialize_choose(text)
    find('label', text: text).click
  end

  def fill_in_ckeditor(locator, opts)
    content = opts.fetch(:with).to_json
    script = <<-SCRIPT
      CKEDITOR.instances['#{locator}'].setData('#{content}');
      $('textarea##{locator}').text('#{content}');
    SCRIPT
    page.evaluate_script(script)
  end

  def pick_date_fill_in(date)
    script = <<-SCRIPT
      $('#purchase_end_date').
        pickadate('picker').
        set('select', '#{date}')
    SCRIPT
    page.evaluate_script(script)
  end

end
