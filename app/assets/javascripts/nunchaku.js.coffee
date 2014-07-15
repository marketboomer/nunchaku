# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require jquery.ui.all
#
#= require bootstrap
#= require bootstrap-datepicker
#= require bootstrap3-editable/bootstrap-editable
#= require select2
#= require gritter
#= require_tree .
#= require_self

$ ->
	$(".select2-container").width("100%")

$ ->
  $("a[data-behaviour='editable']").editable
    params: (params) ->
      params['_method'] = 'put'
      params["#{$(this).data('resource')}[#{params.name}]"] = params.value

      params

window.nunchaku = {}

window.nunchaku.selection_affects_other = (selector, other, url) ->
  $(selector).change ->
    me = $(this)[0]
    $.get(url,
      selection: me.value
    ).done (data) ->
      $(other).replaceWith()
      return
