$(document).ready( ->
  addCommentClickEvents()
)
@addCommentClickEvents = ->
  console.log 'adding comment click events'
  $('.reply-to').click( ->
    console.log 'replying'
    parentCommentId = $(this).attr('id').match(/reply-to-([0-9]+)/)[1]
    $('#comment_form #parent_comment_id').val(parentCommentId)

    parentCommentHTML = $('#comment-' + parentCommentId + ' .comment-body').html()
    $('#comment_form-reply_to-body').html(parentCommentHTML)
    $('#comment_form-reply_to').show()
  )

  $('#cancel-reply-to').click( (e) ->
    console.log 'cancelling reply'
    $('#comment_form #parent_comment_id').val('')
    $('#comment_form-reply_to').hide()
  )
