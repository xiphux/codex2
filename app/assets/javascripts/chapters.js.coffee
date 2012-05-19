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
  appearance_button.qtip({
      content: {
        text: $('.appearance_popup'),
        title: {
          text: 'Appearance',
          button: true
        }
      },
      position: {
        my: 'left center',
        at: 'right center',
        target: [sidebar.position().left + sidebar.width(), appearance_button.position().top + (appearance_button.height()/2)]
      },
      show: {
        event: 'click',
        modal: {
          on: isMobile
        }
      },
      hide: {
        fixed: true,
        event: 'unfocus'
      },
      style: {
        classes: 'codex-tooltip label ui-tooltip-shadow ui-tooltip-rounded'
      }
    })
