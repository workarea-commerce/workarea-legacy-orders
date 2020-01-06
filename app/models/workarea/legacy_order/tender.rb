module Workarea
  class LegacyOrder
    class Tender
      include Mongoid::Document

      field :type, type: String
      field :number, type: String
      field :amount, type: Money
      field :expiration_month, type: String
      field :expiration_year, type: String

      validates_presence_of :type, :amount

      def slug
        "legacy_tender"
      end
    end
  end
end
