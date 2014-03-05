class Goods::ProductTranslation < ActiveRecord::Base
  self.table_name = :goods_product_translations

  # Associations
  belongs_to :product, :class_name => Goods::Product

end