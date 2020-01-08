module Workarea
  module Admin
    class LegacyOrderViewModel < ApplicationViewModel
      delegate_missing_to :storefront_view_model

      def storefront_view_model
        @storefront_view_model ||=
          Storefront::LegacyOrderViewModel.wrap(model, options)
      end
    end
  end
end
