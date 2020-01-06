module Workarea
  module LegacyOrders
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::LegacyOrders

      initializer "workarea.legacy_orders" do
        if Workarea::Plugin.installed?("Workarea::Api")
          api_major, * =  Workarea::Api::VERSION.split(".")
          if api_major != "4"
            raise "This version of Workarea Legacy Orders only supports Workarea Api ~> 4.x"
          end
        end
      end
    end
  end
end
