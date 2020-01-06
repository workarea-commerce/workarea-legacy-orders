require "test_helper"

module Workarea
  module Api
    module Admin
      class LegacyOrdersIntegrationTest < Workarea::IntegrationTest
        include Workarea::Admin::IntegrationTest

        if Plugin.installed?(:api)
          def sample_attributes
            @sample_attributes ||= build_legacy_order.as_json.except("_id").tap do |order|
              order["billing_address"].except!("_id")
              order["shipping_address"].except!("_id")
              order["items"].map! { |i| i.except("_id") }
              order["tenders"].map! { |t| t.except("_id") }
            end
          end

          def test_lists_orders
            orders = [create_legacy_order, create_legacy_order]
            get admin_api.legacy_orders_path(page: 1, sort_by: "created_at", sort_direction: "desc")

            result = JSON.parse(response.body)["orders"]

            assert_equal(2, result.length)
            assert_equal(orders.second, LegacyOrder.new(result.first))
            assert_equal(orders.first, LegacyOrder.new(result.second))
          end

          def test_creates_legacy_orders
            # This has to be set here rather than using sample_attributes directly within assert_difference
            # because the build_legacy_order method will also create a new order,
            # causing the count to increment by 2 if called within the assertion block.
            attrs = sample_attributes

            assert_difference "LegacyOrder.count" do
              post admin_api.legacy_orders_path, params: { order: attrs }, as: :json
            end
          end

          def test_shows_orders
            order = create_legacy_order
            get admin_api.legacy_order_path(order.id)
            result = JSON.parse(response.body)["order"]
            assert_equal(order, LegacyOrder.new(result))
          end

          def test_updates_orders
            order = create_legacy_order
            patch admin_api.legacy_order_path(order.id), params: { order: { email: "szelley@workarea.com" } }

            order.reload
            assert_equal("szelley@workarea.com", order.email)
          end
        end
      end
    end
  end
end
