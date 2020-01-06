module Workarea
  module Factories
    module LegacyOrders
      Factories.add(self)

      def build_legacy_order(overrides = {})
        attributes = {
          email:            "epigeon@workarea.com",
          customer_number:  "1234",
          alternate_number: "O5678",
          placed_at:        DateTime.now,
          status:           "Shipped",
          shipping_method:  "USPS",
          shipping_total:   5.99.to_m,
          tax_total:        2.71.to_m,
          total_price:      53.69.to_m,
          items: [
            {
              name: "City Pigeon - Medium",
              sku: "1410411-025",
              quantity: 2,
              price: 32.to_m,
              details: {
                size: "Medium",
                color: "Charcoal"
              }
            },
            {
              name: "Brass Name Plate",
              sku: "22370",
              quantity: 1,
              price: 12.99.to_m,
              details: {
                material: "Brass"
              },
              customizations: {
                line_1: "Eric",
                line_2: "Rodriguez",
                font_style: "Block"
              }
            }
          ],
          billing_address: {
            name: "Eric Pigeon",
            street: "12 N. 3rd St",
            city: "Philadelphia",
            region: "PA",
            postal_code: "19106",
            country: "US",
            phone_number: "215.925.1800"
          },
          shipping_address: {
            name: "Eric Pigeon",
            street: "12 N. 3rd St",
            city: "Philadelphia",
            region: "PA",
            postal_code: "19106",
            country: "US",
            phone_number: "215.925.1800"
          },
          tenders: [
            {
              type: "Gift Card",
              number: "XXXX1234",
              amount: 25.to_m
            },
            {
              type: "VISA",
              number: "XXXXXXXXXXXX1111",
              amount: 28.69.to_m,
              expiration_month: "12",
              expiration_year: "2017"
            }
          ]

        }.merge(overrides)

        Workarea::LegacyOrder.new(attributes).tap do |order|
          order.fail_due_to_validation! unless order.insert.errors.empty?
        end
      end

      def create_legacy_order(overrides = {})
        build_legacy_order(overrides).tap { |o| o.save! }
      end
    end
  end
end
