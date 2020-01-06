module Workarea
  class LegacyOrder
    class Address
      include Mongoid::Document

      field :name, type: String
      field :street, type: String
      field :street_2, type: String
      field :city, type: String
      field :company, type: String
      field :region, type: String
      field :postal_code, type: String
      field :country, type: String
      field :phone_number, type: String
      field :phone_extension, type: String

      embedded_in :order, class_name: "Workarea::LegacyOrder"

      alias_method :first_name, :name

      def last_name
        ""
      end
    end
  end
end
