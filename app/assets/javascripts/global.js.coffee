#= require jquery
#= require jquery.cookie
$ ->
  $('#themeselect').change (event) ->
    theme = $(event.target).val()
    return if !theme
    $.cookie('codex_theme', theme, { expires: 365, path: '/' })
    body = $('body')[0]
    body.className = body.className.replace(/\b.+_theme\b/g, '')
    $(body).addClass(theme + "_theme")
