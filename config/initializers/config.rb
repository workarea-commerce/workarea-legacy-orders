Workarea.configure do |config|
  config.seeds.insert_after("Workarea::OrdersSeeds", "Workarea::LegacyOrdersSeeds")
  config.jump_to_navigation['Legacy Orders'] = :legacy_orders_path
end
