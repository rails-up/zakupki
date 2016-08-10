jQuery.extend jQuery.fn.pickadate.defaults,
  monthsFull: [
    'января'
    'февраля'
    'марта'
    'апреля'
    'мая'
    'июня'
    'июля'
    'августа'
    'сентября'
    'октября'
    'ноября'
    'декабря'
  ]
  monthsShort: [
    'янв'
    'фев'
    'мар'
    'апр'
    'май'
    'июн'
    'июл'
    'авг'
    'сен'
    'окт'
    'ноя'
    'дек'
  ]
  weekdaysFull: [
    'воскресенье'
    'понедельник'
    'вторник'
    'среда'
    'четверг'
    'пятница'
    'суббота'
  ]
  weekdaysShort: [
    'вс'
    'пн'
    'вт'
    'ср'
    'чт'
    'пт'
    'сб'
  ]
  today: 'сегодня'
  close: 'закрыть'
  firstDay: 1
  format: 'd mmmm yyyy г.'
  formatSubmit: 'yyyy-mm-dd'

$(".purchases.new").ready ->
  $('#purchase_group_id, #purchase_city_id').material_select();
  $('.datepicker').pickadate
    clear: false
    min: true
    selectMonths: true
    selectYears: 2
    closeOnSelect: true
    hiddenName: true
