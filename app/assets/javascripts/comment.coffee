$ ->
  $('.comment-reply').click ->
    $(this).closest('.comment').find('.reply-form').toggle()
    return
	