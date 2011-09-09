jQuery ->
  $('a#follow-question').click ->
    link = $(this)
    $.get this.href, (data) ->
      if data.status
        link.removeClass('success').html("取消关注")
      else
        link.addClass('success').html("关注")
    false
  
  $('a#favorite-question').click ->
    link = $(this)
    $.get this.href, (data) ->
      if data.status
        link.removeClass('success').html("取消收藏")
      else
        link.addClass('success').html "收藏"
    false
  
  $("#new_answer").submit ->
    $.ajax({
      url: $(this).attr("action"),
      type: $(this).attr("method"),
      dataType: "json",
      data: $(this).serialize(),
      beforeSend: (jqXHR, settings) ->
        
      success: (data, textStatus, jqXHR) ->
        alert JSON.stringify(data)
      error: (jqXHR, textStatus, errorThrown) ->
        alert JSON.stringify(jqXHR.responseText)
    })
    false