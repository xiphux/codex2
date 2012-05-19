# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require jquery.qtip
$ ->
  $('#topchapterselect, #bottomchapterselect').change (event) ->
    chapter = $(event.target).val()
    window.location.href = "/fics/" + $('#fic_id').val() + "/chapters/" + chapter
  $('#appearance_button').qtip({
      content: {
        text: $('.appearance_popup')
      },
      position: {
        my: 'left center',
        at: 'right center'
      },
      show: {
        event: 'click'
      },
      hide: {
        fixed: true,
        event: 'unfocus'
      },
      style: {
        classes: 'codex-tooltip label ui-tooltip-shadow ui-tooltip-rounded'
      }
    })
