module Nunchaku::ResourcesCsvHelper
	def csv_export(columns)
	  CSV.generate do |csv|
	    columns = columns

	    csv << decorator_class.human_names(columns)

	    collection.each { |r| csv << columns.map { |c| r.send(c) } }
	  end.html_safe
	end
end