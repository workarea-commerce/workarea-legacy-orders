module Workarea
  module Storefront
    class LegacyOrderViewModel < ApplicationViewModel
      def fulfillment_status
        status
      end

      def requires_shipping?
        shipping_address.present?
      end

      def packages
        []
      end

      def items
        @items ||= LegacyOrderItemViewModel.wrap(model.items)
      end
    end
  end
end
