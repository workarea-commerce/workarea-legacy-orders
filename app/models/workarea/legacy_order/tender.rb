module Workarea
  class LegacyOrder
    class Tender
      include ApplicationDocument

      field :tender_type, type: String
      field :number, type: String
      field :amount, type: Money
      field :issuer, type: String
      field :expiration_month, type: String
      field :expiration_year, type: String
      field :data, type: Hash, default: {}

      validates_presence_of :type, :amount
      alias_method :type, :tender_type
      alias_method :type=, :tender_type=

      def slug
        "legacy_tender"
      end

      def issuer
        super.presence || type
      end
    end
  end
end
