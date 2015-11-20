require 'csv'
require 'erb'

class ProductsController < ApplicationController
  def seed_products
    @products = []
    CSV.foreach(Rails.root + "mf_inventory.csv", headers: true) do |row|

      product = Product.new
      product.pid = row.to_h["pid"]
      product.item = row.to_h["item"]
      product.description = row.to_h["description"]
      product.price = row.to_h["price"]
      product.img_file = row.to_h["img_file"]
      product.condition = row.to_h["condition"]
      product.dimension_w = row.to_h["dimension_w"]
      product.dimension_l = row.to_h["dimension_l"]
      product.dimension_h = row.to_h["dimension_h"]
      product.quantity = row.to_h["quantity"]
      product.category = row.to_h["category"]

      if product.condition == "good"
        product.price = product.price.to_i * 0.9
        product.discount = "10%"
      elsif product.condition == "average"
        product.price = product.price.to_i * 0.8
        product.discount = "20%"
      end

      if product.img_file == "outdoor-chair-3"
        product.img_file = "No image available"
      end

      if product.pid.to_i >= 1
        product.pid = product.pid.to_i
      end
      @products << product
    end

    @products
  end

  def home
  end

  def list
    @products = seed_products
  end

  def detail
    @products = seed_products
    @product = @products.find {|p| p.pid == params[:pid].to_i }
  end
end
