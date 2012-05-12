# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require jquery
#= require global
$ ->
  $('.ficfilters .searchtype').each (index, element) ->
    searchtypename = $(this).find('.searchtypename')
    name = $.trim(searchtypename.text())
    link = $(document.createElement('a')).attr('href', '#')
    link.text(name)
    searchtypename.empty().append(link)
    link.click (event) ->
      searchtypevalues = $(this).parents('.searchtype').find('.searchtypevalues')
      if searchtypevalues.is(':visible')
        searchtypevalues.animate({height: 'hide',opacity: 'hide'}, 'fast')
        $(this).text($(this).text() + "...")
      else
        searchtypevalues.animate({height: 'show',opacity: 'show'}, 'fast')
        $(this).text($(this).text().replace(/\.*$/, ''))
      return false
    $(this).find('.searchtypevalues').hide()
    link.text(link.text() + "...")
