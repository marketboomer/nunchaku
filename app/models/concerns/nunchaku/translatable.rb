module Nunchaku::Translatable
  extend ActiveSupport::Concern
  include Nunchaku::FuzzySearchable

  included do
    has_many :translations, :dependent => :destroy, :class_name => translation_class_name
    before_save :concatenate
    before_save :update_existing_translations, unless: Proc.new { |it| it.new_record? }
    after_save :update_translations, if: Proc.new { |it| it.id_changed? }
  end

  module ClassMethods

    def translation_table_name
      table_name.singularize + '_translations'
    end

    def translation_table_exists?
      ActiveRecord::Base.connection.table_exists? translation_table_name
    end

    def translation_class_name
      "#{self.name}Translation" if translation_table_exists?
    end

    def translation_class
      translation_class_name.constantize
    end

    def translation_foreign_key
      "#{self.name.split('::').last.underscore}_id"
    end

    def translatable_attributes
      translation_class.column_names - excluded_attributes
    end

    def excluded_attributes # Attributes which are not to be copied either from or to translations:
      ( %w(id lock_version updated_at created_at) + parent_attributes ) << translation_foreign_key
    end

    def sort_attributes
      %w(search_text)
    end

    def parent_attributes
      sort_attributes.map { |a| "parent_#{a}" }
    end

    # Each model must define its own derived attributes to populate them via the update callback:
    def derived_translation_attributes
      []
    end

    # Returns all translated instances (can be chained on to the end of a standard search method call:
    def t(locale=I18n.locale)
      select((parent_targets+translation_targets).join(',')).t_join(locale)
    end

    def t_join(locale=I18n.locale)
      joins(%Q[
        LEFT JOIN #{translation_table_name} ON #{table_name}.id = #{translation_table_name}.#{translation_foreign_key}
        AND #{translation_table_name}.locale = '#{locale}'
        ])
    end

    def t_search(terms) # NOTE: This method needs to be used for any chaining of search to translated entities.
      return where(nil) if terms.blank?
      where(terms.map { |term| "#{translation_table_name}.search_text ILIKE ?" }.join(' AND '), *(terms.map { |t| "%#{t}%" }))
    end

    def fuzzy_search terms, opts = {}
      locale = opts[:locale] || I18n.locale
      if terms.empty?
        t_join(locale).where("#{translation_table_name}.id IS NOT NULL") # Vital for performance of order by with limit
      else
        t_join(locale).t_search(terms).where("#{translation_table_name}.locale = ?", locale)
      end
    end

    def translated_search(terms, locale=I18n.locale)
      fuzzy_search(terms, :locale => locale).t(locale)
    end

    def parent_targets
      (column_names - translatable_attributes).map { |c| "#{table_name}.#{c}" }
    end

    # Translation target fields use the value from the parent if there is no tranlsation.
    def translation_targets
      translatable_attributes.map do |c|
        %Q[
          CASE WHEN #{translation_table_name}.locale IS NULL THEN #{table_name}.#{c}
          ELSE #{translation_table_name}.#{c}
          END
        ]
      end
    end

    def unique?(id, *args)
      wt = with_translation(*args)
      wt.empty? or wt.first.id == id.to_i #the id can be a string, integer or nil
    end

    # WARNING: The "lower" call below will result in a table scan unless there is a functional index on that column.
    def with_translation(locale, attr_name, value, options={})
      readonly(false).
      joins(translation_table_name.to_sym)
      .where("lower(#{translation_table_name}.#{attr_name}) = ? AND #{translation_table_name}.locale = ?", value.downcase.strip, locale)
      .where(options[:where])
    end

    def with_translation_value(attr_name, value, options={})
      readonly(false).
      joins(translation_table_name.to_sym)
      .where("lower(#{translation_table_name}.#{attr_name}) = ?", value.downcase.strip)
      .where(options[:where])
    end
  end

  def t(locale=I18n.locale) #return self if request locale is same as the current locale
    return self if self.locale == locale # Doesn't need translation
    t = translations.where(:locale => locale).first
    return self unless t # Just return the object if for some strange reason there is no translation
    assign_attributes(
        t.attributes.delete_if do |k, v|
          k.in?(self.class.excluded_attributes) || k.in?(self.class.derived_translation_attributes)
        end
    )
    self
  end

  # Use t instead of t_attr as much as possible (not sure this is even needed)
  def t_attr(locale=I18n.locale, attr_name)
    return self.send(attr_name).to_s if self.locale == locale
    t = translations.where(:locale => locale).first
    t ? t.send(attr_name).to_s : self.send(attr_name).to_s
  end

  def has_translation?(locale=I18n.locale)
    self.class.translation_class.where(self.class.translation_foreign_key => id, 'locale' => locale).exists?
  end

  # Concatenate all text or string values that arent locale, search_text or prefixed with concatenated, put them in search_text and hanize
  def concatenate
    cols = self.class.columns_hash.reject do |k, v|
      v.name.in?('search_text', 'locale') || (v.name.split('_').first == 'concatenated') || !v.type.in?(:string, :text)
    end
    self.search_text = cols.map { |k, v| send(v.name).to_s }.reject(&:blank?).join(' ').hanize
  end

  private

  def update_translations
    translation = self.class.translation_class.where(self.class.translation_foreign_key => id, 'locale' => locale).first_or_initialize
    translation.assign_attributes(
        attributes.delete_if do |k, v|
          !k.in?(self.class.translation_class.column_names) || k.in?(self.class.excluded_attributes)
        end
    )
    set_sort_attributes(translation)
    self.class.derived_translation_attributes.each { |att| translation.send("#{att}=", send(att)) }
    translation.save
  end

  def set_sort_attributes trans
    self.class.sort_attributes.each do |att|
      trans.send("parent_#{att}=", send(att)) if trans.attributes.has_key?("parent_#{att}")
    end
  end

  def update_existing_translations
    update_translations
    restore_original if locale_was == 'en' && locale != 'en'# We don't want to overwrite the parent if it is already English locale!
  end

  def restore_original
    attributes.except('id').each { |k,v| self.send("#{k}=", self.send("#{k}_was")) }
  end

end
