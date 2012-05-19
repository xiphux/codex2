# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require jquery.qtip
$ ->
  $('#topchapterselect, #bottomchapterselect').change (event) ->
    chapter = $(event.target).val()
    window.location.href = "/fics/" + $('#fic_id').val() + "/chapters/" + chapter
  isMobile = navigator.userAgent.match(/(iPhone|iPod|iPad|Android|BlackBerry)/)
  appearance_button = $('#appearance_button')
  sidebar = $('.chapter_sidebar')
  if appearance_button.length > 0 && sidebar.length > 0
    appearance_button.qtip({
        content:
          text: $('.appearance_popup')
          title:
            text: 'Appearance'
            button: true
        position:
          my: 'left center'
          at: 'right center'
          target: [sidebar.position().left + sidebar.width(), appearance_button.position().top + (appearance_button.height()/2)]
        show:
          event: 'click'
          modal:
            on: isMobile
        hide:
          fixed: true
          event: 'unfocus'
        style:
          classes: 'codex-tooltip label ui-tooltip-shadow ui-tooltip-rounded'
      })
  spelling_button = $('#spelling_button')
  if spelling_button.length > 0 && sidebar.length > 0
    spelling_button.qtip({
        content:
          text: $('.spelling_popup')
          title:
            text: 'Spelling Fixes'
            button: true
        position:
          my: 'left center'
          at: 'right center'
          target: [sidebar.position().left + sidebar.width(), spelling_button.position().top + (spelling_button.height()/2)]
        show:
          event: 'click'
          modal:
            on: isMobile
          autofocus: '#spelling_original'
        hide:
          fixed: true
          event: 'unfocus'
        style:
          classes: 'codex-tooltip label ui-tooltip-shadow ui-tooltip-rounded'
        events:
          hide: (event, api) ->
            $('#spelling_original').val('')
            $('#spelling_replacement').val('')
      })
    $('#spelling_form').submit (event) ->
      original = $('#spelling_original').val()
      if original && original.length > 0
        $.post this.action, $(this).serialize(), (response) ->
          replacement = $('#spelling_replacement').val()
          textcontainer = $('.readtext')
          regex = new RegExp("\\b" + original + "\\b")
          textcontainer.html(textcontainer.html().replace(regex, replacement))
          $('#spelling_button').qtip('hide')
      return false

