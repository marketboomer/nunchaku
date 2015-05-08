class MultiAutocompleteInput < AutocompleteInput

  def input_id
    "#{object_name}_#{object.send(options[:id_method_name])}_#{attribute_name}"
  end
end
