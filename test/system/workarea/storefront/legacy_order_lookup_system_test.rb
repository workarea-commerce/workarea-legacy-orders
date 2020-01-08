require 'test_helper'

module Workarea
  module Storefront
    class LegacyOrderLookupSystemTest < Workarea::SystemTest
      def test_looking_up_legacy_order
        order = create_legacy_order(id: 'LO1')

        visit storefront.check_orders_path

        fill_in :order_id, with: 'LO1'
        fill_in :postal_code, with: '19106'

        click_button t('workarea.storefront.orders.lookup_order')

        assert_current_path(storefront.order_path('LO1'))
        assert(page.has_content?(order.billing_address.first_name))
      end
    end
  end
end
