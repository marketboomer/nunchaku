module Nunchaku::ResourcesPdfHelper

  # Generic SQL solution for large reports that assumes all totals are basic sums against columns from resource class.
  # If this isn't true you will have to roll your own version on a per report (possibly per total) basis.
  def report_totals
    decorator_class.total_columns.inject({}) do |h, col|
      h[col] = totals_collection.take(1).first.send("#{col}_sum")
      h
    end
  end

  def totals_collection
    c.unscope(:select, :order, :includes).select(select_totals)
  end

  def select_totals
    decorator_class.total_columns.map do |col|
      "sum(#{resource_class.table_name}.#{col}) as #{col}_sum"
    end.join(', ')
  end

  # Fallback method with potentially large performance impact since it instantiates the whole collection
  def simple_report_totals
    h = {}
    collection.each do |obj|
       decorator_class.total_columns.each do |col|
         h[col] ||= 0
         h[col] += (obj.send(col).to_s.gsub(',','').to_f || 0) # to_s.gsub is needed because Rails can't determine the type of SQL aggregates
       end
    end
    h
  end
end