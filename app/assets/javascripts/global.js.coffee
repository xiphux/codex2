#= require jquery.cookie
$ ->
  $('#themeselect').change (event) ->
    theme = $(event.target).val()
    return if !theme
    $.cookie('codex_theme', theme, { expires: 365, path: '/' })
    body = $('body')[0]
    body.className = body.className.replace(/\b[a-zA-Z0-9]+_theme\b/g, '')
    $(body).addClass(theme + "_theme")
  $('#textsizeselect').change (event) ->
    textsize = $(event.target).val()
    return if !textsize
    $.cookie('codex_font_size', textsize, { expires: 365, path: '/' })
    readtext = $('.readtext')[0]
    readtext.className = readtext.className.replace(/\b[a-zA-Z0-9]+_size\b/g, '')
    $(readtext).addClass(textsize + "_size");
