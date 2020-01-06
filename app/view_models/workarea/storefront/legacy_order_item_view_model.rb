module Workarea
  module Storefront
    class LegacyOrderItemViewModel < ApplicationViewModel
      def sku_name
        name
      end

      def total_price
        price
      end
    end
  end
end
