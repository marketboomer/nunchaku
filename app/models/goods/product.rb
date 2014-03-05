class Goods::Product < ActiveRecord::Base
  self.table_name = :goods_products

  include Nunchaku::Translatable

  # Associations
  belongs_to :product_subcategory
  has_many :catalogued_products

  has_many :pricings, class_name: 'CataloguedProduct'
  has_many :catalogues, through: :pricings

  # Callbacks
  after_validation :concatenate

  class << self

    def excluded_attributes
      super << 'product_key'
    end

    def sort_attributes
      %w(search_text concatenated_brand concatenated_sell_unit concatenated_description)
    end

    def translation_class_name
      'Goods::ProductTranslation'
    end

  end

  def copy
    Goods::Product.new(self.attributes).tap do |p|
      p.created_at = nil
      p.updated_at = nil
      p.lock_version = 0
    end
  end

  def concatenated_details
    [self.concatenated_brand, self.concatenated_description, self.concatenated_sell_unit].reject{|x| x.blank? }.join(' ')
  end

  def master_product?
    master_catalogues.any?
  end

  def master_catalogues
    catalogues.where(catalogues: { type: 'MasterCatalogue' } )
  end

  def lowest_pricing(catalogues)
    CataloguedProduct.for_product(self).in_catalogues(catalogues).by_sell_unit_price.limit(1)
  end

  def add_to_catalogues(catalogues)
    catalogues.map { |c| CataloguedProduct.find_or_create_by_catalogue_id_and_product_id(c, self) }
  end

  def to_s
    "#{concatenated_brand} #{concatenated_description} #{concatenated_sell_unit}"
  end

  protected

  def concatenate
    self.concatenated_brand = _concatenated_brand
    self.concatenated_description = _concatenated_description
    self.concatenated_sell_unit = _concatenated_sell_unit
    self.search_text = _search_text
  end

  def _concatenated_brand
    [brand, range_model, manufacturer_code].reject{|x| x.blank? }.join(' ')
  end

  def _concatenated_description
    [item_description, item_description_qualifier, package_inner,
     average_weight_quantity, average_weight_measure, country_of_origin,
     state_province, region, package_quantity_length_dimension,
     package_quantity_width_dimension, package_quantity_height_dimension,
     package_quantity_dimension_measure, item_size, item_measure,
     item_pack_name].reject {|x| x.blank? }.join(' ')
  end

  def _concatenated_sell_unit
    [item_sell_quantity.to_s, item_sell_measure, item_sell_pack_name].reject { |x| x.blank? }.join(' ')
  end

  def _search_text
    [_concatenated_brand, _concatenated_description, _concatenated_sell_unit].reject { |x| x.blank? }.join(' ').hanize
  end

end