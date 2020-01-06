Workarea::Storefront::Engine.routes.draw do
  scope '(:locale)', constraints: Workarea::I18n.routes_constraint do
    namespace :users do
      resources :legacy_orders, only: [:show]
    end
  end
end

Workarea::Admin::Engine.routes.draw do
  scope '(:locale)', constraints: Workarea::I18n.routes_constraint do
    resources :legacy_orders, only: [:index, :show]
  end
end

if Workarea::Plugin.installed?("Workarea::Api")
  Workarea::Api::Admin::Engine.routes.draw do
    resources :legacy_orders, except: %i[new edit destroy]
  end
end
