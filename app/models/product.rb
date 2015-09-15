class Product
  attr_accessor :pid, :item, :description, :price, :condition, :dimension_w, :dimension_l, :dimension_h, :quantity, :category, :discount, :image

  def product_name
    @pid.to_s
  end
end
