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

window.nunchaku.selection_affects_other = (selector, other, url) ->
  $(document).off "change", selector
  $(document).on "change", selector, ->
    $.get(url, selection: $(this)[0].value).done (data) ->
      $(other).replaceWith data
      return

window.nunchaku.is_empty = (value) ->
  typeof (value) is "undefined" or not value? or value is ""
