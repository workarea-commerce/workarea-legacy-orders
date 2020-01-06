$:.push File.expand_path("../lib", __FILE__)

require "workarea/legacy_orders/version"

Gem::Specification.new do |spec|
  spec.name        = "workarea-legacy_orders"
  spec.version     = Workarea::LegacyOrders::VERSION
  spec.authors     = ["Matt Duffy"]
  spec.email       = ["mduffy@workarea.com"]
  spec.homepage    = "https://github.com/workarea-commerce/workarea-legacy-orders"
  spec.summary     = "Workarea Commerce plugin to support imported orders"
  spec.description = "Workarea Commerce plugin to support imported orders"
  spec.license     = "Business Software License"

  spec.files = `git ls-files`.split("\n")

  spec.add_dependency "workarea", "~> 3.x", ">= 3.4.x"
end
