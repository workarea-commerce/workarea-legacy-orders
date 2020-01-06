require "test_helper"

module Workarea
  module Storefront
    class OrderHistorySystemTest < Workarea::SystemTest
      setup :setup_current_user

      def setup_current_user
        @user ||= create_user(email: "epigeon@workarea.com")
        set_current_user(@user)
      end

      def test_viewing_legacy_orders_in_list
        create_legacy_order(id: "LEGACY")
        create_legacy_order(id: "VINTAGE")

        visit storefront.check_orders_path

        assert(page.has_content?("Number LEGACY"))
        assert(page.has_content?("Number VINTAGE"))
      end

      def test_viewing_a_legacy_order
        order = create_legacy_order(number: "LEGACY")

        visit storefront.users_order_path(order)

        assert(page.has_content?("LEGACY"))
        assert(page.has_content?("City Pigeon - Medium"))
        assert(page.has_content?("Size: Medium"))
        assert(page.has_content?("Color: Charcoal"))

        assert(page.has_content?("Brass Name Plate"))
        assert(page.has_content?("Material: Brass"))
        assert(page.has_content?("Line 1: Eric"))
        assert(page.has_content?("Line 2: Rodriguez"))

        assert(page.has_content?("Subtotal $44.99"))
        assert(page.has_content?("Shipping $5.99"))
        assert(page.has_content?("Tax $2.71"))
        assert(page.has_content?("Total $53.69"))
      end

      def test_viewing_a_regular_order
        order = create_placed_order(user_id: @user.id, email: @user.email)

        visit storefront.users_order_path(order)

        assert(page.has_content?(order.id))
      end
    end
  end
end
