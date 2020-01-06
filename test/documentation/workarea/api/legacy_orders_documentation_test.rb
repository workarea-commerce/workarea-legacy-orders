require "test_helper"

if Workarea::Plugin.installed?("Workarea::Api")
  require "workarea/api/documentation_test"

  module Workarea
    module Api
      class LegacyOrdersDocumentationTest < DocumentationTest
        if Plugin.installed?(:api)
          include Workarea::Admin::IntegrationTest

          resource "LegacyOrders"

          def sample_attributes
            @sample_attributes ||= build_legacy_order.as_json.except("_id").tap do |order|
              order["billing_address"].except!("_id")
              order["shipping_address"].except!("_id")
              order["items"].map! { |i| i.except("_id") }
              order["tenders"].map! { |t| t.except("_id") }
            end
          end

          def test_and_document_index
            description "Listing legacy orders"
            route admin_api.legacy_orders_path
            parameter :page, "Current page"
            parameter :sort_by, "Field on which to sort (see responses for possible values)"
            parameter :sort_direction, "Direction to sort (asc or desc)"

            2.times { create_legacy_order }

            record_request do
              get admin_api.legacy_orders_path(page: 1, sort_by: "created_at", sort_direction: "desc")

              assert_equal(200, response.status)
            end
          end

          def test_and_document_create
            description "Creating legacy orders"
            route admin_api.legacy_orders_path

            record_request do
              post admin_api.legacy_orders_path, params: { order: sample_attributes }, as: :json

              assert_equal(201, response.status)
            end
          end

          def test_and_document_show
            description "Showing a legacy order"
            legacy_order = create_legacy_order

            route admin_api.legacy_order_path(legacy_order)

            record_request do
              get admin_api.legacy_order_path(legacy_order)

              assert_equal(200, response.status)
            end
          end

          def test_and_document_update
            description "Updating a legacy order"
            legacy_order = create_legacy_order

            route admin_api.legacy_order_path(legacy_order.id)

            record_request do
              patch admin_api.legacy_order_path(create_legacy_order.id),
                params: { order: sample_attributes },
                as: :json

              assert_equal(204, response.status)
            end
          end
        end
      end
    end
  end
end
