# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#topchapterselect, #bottomchapterselect').change (event) ->
    chapter = $(event.target).val()
    window.location.href = "/fics/" + $('#fic_id').val() + "/chapters/" + chapter
