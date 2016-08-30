module AcceptanceHelper
  def materialize_choose(text)
    find('label', text: text).click
  end

  def fill_in_ckeditor(locator, opts)
    content = opts.fetch(:with).to_json
    page.execute_script <<-SCRIPT
      CKEDITOR.instances['#{locator}'].setData('#{content}');
      $('textarea##{locator}').text('#{content}');
    SCRIPT
  end

  def pick_date_fill_in(date)
    page.execute_script <<-SCRIPT
      $('#purchase_end_date').
        pickadate('picker').
        set('select', '#{date}')
    SCRIPT
  end
end
