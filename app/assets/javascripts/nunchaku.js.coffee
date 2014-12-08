# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require jquery.ui.all
#
#= require bootstrap
#= require bootstrap3-editable/bootstrap-editable
#= require gritter
#= require_tree .
#= require_self

$ ->
	$(".select2-container").width("100%")
	$('.tree-item-name span').tooltip()

$ ->
  $("a[data-behaviour='editable']").editable
    params: (params) ->
      params['_method'] = 'put'
      params["#{$(this).data('resource')}[#{params.name}]"] = params.value

      params

window.nunchaku = {}
window.nunchaku.enter_key = 13
window.nunchaku.up_key = 38
window.nunchaku.down_key = 40

window.nunchaku.selection_affects_other = (selector, other, url) ->
  $(document).off "change", selector
  $(document).on "change", selector, ->
    $.get(url, selection: $(this)[0].value).done (data) ->
      $(other).replaceWith data
      return

window.nunchaku.is_empty = (value) ->
  typeof (value) is "undefined" or not value? or value is ""

window.nunchaku.editable_field = (selector, ajax_callback) ->
  $(selector).off "change keydown keyup focusin"
  $(selector).each (i) ->
    $(this).attr "tabindex", i + 1
    return

  $(selector).change ->
    ajax_callback $(this)
    return

  $(selector).keydown (e) ->
    if e.which is window.nunchaku.enter_key
      $(selector + ":eq(" + ($(selector).index(this) + 1) + ")").focus()
    return

  $(selector).keyup (e) ->
    if e.which is window.nunchaku.up_key or e.which is window.nunchaku.down_key
      index = $(selector).index(this)
      $(selector + ":eq(" + ((if e.which is window.nunchaku.up_key then index - 1 else index + 1)) + ")").focus()
    return

  $(selector).focusin ->
    $(this).select()

  return
