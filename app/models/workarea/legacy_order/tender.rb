module Workarea
  class LegacyOrder
    class Tender
      include Mongoid::Document

      field :type, type: String
      field :number, type: String
      field :amount, type: Money
      field :issuer, type: String
      field :expiration_month, type: String
      field :expiration_year, type: String
      field :data, type: Hash, default: {}

      validates_presence_of :type, :amount

      def slug
        "legacy_tender"
      end

      def issuer
        super.presence || type
      end
    end
  end
end
