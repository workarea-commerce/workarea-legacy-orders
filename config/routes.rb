Rails.application.routes.draw do
  Workarea::Storefront::Engine.routes.draw do
    namespace :users do
      resources :legacy_orders, only: [:show]
    end
  end

  if Workarea::Plugin.installed?("Workarea::Api")
    Workarea::Api::Admin::Engine.routes.draw do
      resources :legacy_orders, except: %i[new edit destroy]
    end
  end
end
