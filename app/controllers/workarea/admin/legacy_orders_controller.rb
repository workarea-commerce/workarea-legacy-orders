module Workarea
  module Admin
    class LegacyOrdersController < Admin::ApplicationController
      def index
        search = Search::AdminLegacyOrders.new(params)
        @search = Admin::OrderSearchViewModel.new(search, view_model_options)
      end

      def show
        @order = Admin::LegacyOrderViewModel.wrap(
          LegacyOrder.find(params[:id]),
          view_model_options
        )
      end
    end
  end
end
