module Workarea
  class LegacyOrder
    class Address
      include ApplicationDocument

      field :first_name, type: String
      field :last_name, type: String
      field :street, type: String
      field :street_2, type: String
      field :city, type: String
      field :company, type: String
      field :region, type: String
      field :postal_code, type: String
      field :country, type: Country
      field :phone_number, type: String
      field :phone_extension, type: String

      embedded_in :order, class_name: "Workarea::LegacyOrder"

      alias_method :name=, :first_name=
      alias_method :region_name, :region

      def name
        [first_name, last_name].compact.join(' ')
      end
    end
  end
end
