Workarea.configure do |config|
  config.seeds.insert_after("Workarea::OrdersSeeds", "Workarea::LegacyOrdersSeeds")
end
