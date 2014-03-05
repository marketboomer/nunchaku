module Nunchaku::ResourcesSummaryHelper
  def summary(resource)
    resource.class.ancestors.map(&:name).compact.each do |n|
      begin
        return render(summary_location(n), :locals => { :resource => resource })
      rescue ActionView::MissingTemplate => e
      end
    end
  end

  def summary_location(name)
    "#{name.underscore.pluralize}/summary"
  end
end