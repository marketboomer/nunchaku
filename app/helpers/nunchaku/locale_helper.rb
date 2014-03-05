module Nunchaku::LocaleHelper
	def human(model)
		model.model_name.human
	end

	def human_attrs(model, attrs_nonhuman)
		attrs_nonhuman.map { |a| human_attr(model, a) }
	end

	def human_attr(model, attr_nonhuman)
		model.human_attribute_name(attr_nonhuman.to_sym)
	end
end