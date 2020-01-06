module Workarea
  if Plugin.installed?("Workarea::Api")
    module Api
      module Admin
        class LegacyOrdersController < Workarea::Api::Admin::ApplicationController
          def index
            @orders = LegacyOrder
              .all
              .order_by(sort_field => sort_direction)
              .page(params[:page])

            respond_with orders: @orders
          end

          def create
            @order = LegacyOrder.create!(params[:order])
            respond_with(
              { order: @order },
              status: :created,
              location: legacy_order_path(@order.id)
            )
          end

          def show
            @order = LegacyOrder.find(params[:id])
            respond_with order: @order
          end

          def update
            @order = LegacyOrder.find(params[:id])
            @order.update_attributes!(params[:order])
            respond_with order: @order
          end

          private

            def sort_field
              params[:sort_by].presence || :placed_at
            end
        end
      end
    end
  end
end
