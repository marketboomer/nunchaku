# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require jquery.ui.sortable
#
#= require bootstrap
#= require bootstrap-datepicker
#= require bootstrap3-editable/bootstrap-editable
#= require select2
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
