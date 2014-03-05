# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#
#= require twitter/bootstrap
#= require bootstrap-datepicker
#= require select2
#= require bootstrap-editable
#= require_tree .
#= require_self

$ ->
  $("a[data-behaviour='editable']").editable
    params: (params) ->
      params['_method'] = 'put'
      params["#{$(this).data('resource')}[#{params.name}]"] = params.value

      params

$ ->
	$(".select2-container").width("100%")