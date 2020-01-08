module Workarea
  module Search
    class AdminLegacyOrders
      include Query
      include AdminIndexSearch
      include AdminSorting
      include Pagination

      document Search::Admin

      def initialize(params = {})
        super(params.merge(type: 'legacy_order'))
      end

      def facets
        super + [TermsFacet.new(self, 'order_status')]
      end

      def filters
        [
          DateFilter.new(self, 'placed_at', :gte),
          DateFilter.new(self, 'placed_at', :lte),
          RangeFilter.new(self, 'total_price', :gte),
          RangeFilter.new(self, 'total_price', :lt)
        ]
      end

      def current_sort
        AdminOrders.available_sorts.find(params[:sort])
      end
    end
  end
end
