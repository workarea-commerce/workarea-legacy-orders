module Workarea
  module Storefront
    class LegacyOrderViewModel < ApplicationViewModel
      def fulfillment_status
        status
      end

      def requires_shipping?
        shipping_address.present?
      end

      def items
        @items ||= LegacyOrderItemViewModel.wrap(model.items)
      end

      def pending_items
        items.select { |i| i.status == 'pending' }
      end

      def shipped_items
        items.select { |i| i.status == 'shipped' }
      end

      def canceled_items
        items.select { |i| i.status == 'canceled' }
      end

      def packages
        []
      end

      def refunds
        []
      end
    end
  end
end
