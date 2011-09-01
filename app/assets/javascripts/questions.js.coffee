jQuery ->
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