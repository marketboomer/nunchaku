module Nunchaku::DebugHelper
	def collection_to_sql
		content_tag(:pre, collection.to_sql)
	end
end