$ ->
  $('input.delivery_payment').change ->
    $('input.delivery_payment:checked').each ->
      idVal = $(this).attr('id')
      text = $('label[for=' + idVal + ']').text()
      if text == 'фиксированная стоимость'
        $('#flat_shipping_price').show()
        $('#purchase_flat_shipping_price').focus()
      else
        $('#flat_shipping_price').hide()
      return
    return
  return
