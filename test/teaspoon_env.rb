require "workarea/testing/teaspoon"

Teaspoon.configure do |config|
  config.root = Workarea::LegacyOrders::Engine.root
  Workarea::Teaspoon.apply(config)
end
