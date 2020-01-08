module Workarea
  module Search
    class Admin
      class LegacyOrder < Search::Admin
        def name
          if model.billing_address.present?
            model.billing_address.name
          else
            model.name
          end
        end

        def search_text
          [
            'order',
            model.id,
            model.status,
            model.email,
            model.customer_number,
            model.alternate_number,
            model.items.map { |i| "#{i.product_id} #{i.sku}" },
            model.shipping_method,
            addresses_text,
            tenders_text
          ].flatten.join(' ')
        end

        def keywords
          super + [model.email, model.alternate_number]
        end

        def jump_to_text
          if model.placed?
            "#{model.id} - Placed @ #{model.placed_at.to_s(:short)}"
          else
            "#{model.id} - #{model.status.to_s.titleize}"
          end
        end

        def jump_to_position
          3
        end

        def facets
          super.merge(order_status: model.status)
        end

        def as_document
          super.merge(
            total_price: model.total_price.to_f,
            placed_at: model.placed_at
          )
        end

        def addresses_text
          [model.shipping_address, model.billing_address].map do |address|
            [
              address.first_name,
              address.last_name,
              address.company,
              address.street,
              address.street_2,
              address.city,
              address.region,
              address.postal_code,
              address.country,
              address.phone_number
            ]
          end.flatten
        end

        def tenders_text
          model.tenders.map do |tender|
            [tender.issuer, tender.type]
          end.flatten
        end
      end
    end
  end
end
