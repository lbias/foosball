$(document).on 'ready page:load', ->

  Materialize.updateTextFields()
  $(".button-collapse").sideNav()
  if $('#notification').length
    Materialize.toast($('#notification').data('text'), 4000)
