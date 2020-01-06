module Workarea
  module Storefront
    class LegacyOrderItemViewModel < ApplicationViewModel
      def sku_name
        name
      end

      def total_price
        price
      end

      def has_options?
        model.details.present?
      end

      def product_name
        return sku_name unless product.present?
        product.name
      end

      def product
        return nil if product_id.blank?
        return @product if defined?(@product)

        model = Catalog::Product.find(product_id) rescue nil
        @product = model.present? ? ProductViewModel.wrap(model, sku: sku) : nil
      end

      def image
        if product.present?
          product.primary_image
        else
          Catalog::ProductPlaceholderImage.cached
        end
      end
    end
  end
end
