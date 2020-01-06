module Workarea
  class LegacyOrder
    class Item
      include Mongoid::Document

      field :name, type: String
      field :sku, type: String
      field :quantity, type: Integer
      field :price, type: Money
      field :details, type: Hash, default: {}
      field :customizations, type: Hash, default: {}

      embedded_in :order, class_name: "Workarea::LegacyOrder"

      validates_presence_of :name, :sku, :quantity, :price
    end
  end
end
