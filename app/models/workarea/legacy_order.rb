module Workarea
  class LegacyOrder
    include ApplicationDocument

    field :_id, type: String, default: -> { SecureRandom.hex(5).upcase }
    field :email, type: String
    field :customer_number, type: String
    field :alternate_number, type: String
    field :placed_at, type: DateTime
    field :status, type: String, default: "Shipped"
    field :shipping_method, type: String
    field :shipping_total, type: Money
    field :tax_total, type: Money
    field :total_price, type: Money
    field :discount_total, type: Money

    embeds_many :items, class_name: "Workarea::LegacyOrder::Item"
    embeds_one :billing_address, class_name: "Workarea::LegacyOrder::Address"
    embeds_one :shipping_address, class_name: "Workarea::LegacyOrder::Address"
    embeds_many :tenders, class_name: "Workarea::LegacyOrder::Tender"

    index(email: 1)

    validates_presence_of :email, :placed_at, :tax_total, :total_price

    default_scope -> { order_by(:placed_at.desc) }

    def self.for_email(email)
      where(email: email)
    end

    def self.lookup(id, postal_code)
      order = find(id) rescue nil
      order&.billing_address&.postal_code == postal_code ? order : nil
    end

    def name
      I18n.t('workarea.order.name', id: id)
    end

    # The number of units in this order.
    #
    # @return [Integer]
    #
    def quantity
      items.sum(&:quantity)
    end

    def subtotal_price
      items.sum(&:price)
    end

    def placed?
      placed_at.present?
    end
  end
end
