$(document).on 'turbolinks:load', ->

  $('td').on 'click', (e) ->
    if @.className == 'empty' && $('.table-board')[0].className != 'table-board end'
      id = @.id
      $.post
        url: 'game/results'
        data:
          id: id
        success: (data) ->
          redrawTable(data,  id)
        error: ->
          alert('failed')


  redrawTable = (data, id) ->
    if data.value != 'undefined'
      $('#'+id).html(data.value)
      $('#'+id).attr('class', 'full ' + data.value);
      if data.win
        $('.winner').html(data.value + ": winner winner chicken dinner!!")
        $('.table-board').attr('class', 'table-board end')