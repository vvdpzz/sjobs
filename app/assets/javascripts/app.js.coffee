jQuery ->
  
  $('body').bind 'click', (e) ->
    $('a.dropdown-toggle').parent('li').removeClass('open')
  
  $('a.dropdown-toggle').click ->
    $(this).parent('li').toggleClass('open')
    false