class ActiveRecord::Relation
  HUGE_COUNT = 20000

  def count(column_name = nil, options = {})
    exact, has_conditions = false, false
    h = (column_name.class == Hash ? column_name : options)
    exact = h[:exact]
    has_conditions = h[:conditions]
    has_distinct = (column_name.class == String) && (column_name =~ /\bdistinct\b/i)
    h = h.except(:exact) # Remove it because super won't understand it
    column_name.class == Hash ? column_name = h : options = h
    if exact || has_conditions || has_distinct
      super
    else
      est = estimated_count
      est > HUGE_COUNT ? est : super
    end
  end

  def estimated_count
    node = {}
    connection.unprepared_statement do
      node = connection.execute("EXPLAIN #{self.to_sql}").first
    end
    match = node['QUERY PLAN'].match(/rows=\d+\b/)
    match ? match[0].split('=').last.to_i : 0
  end

end