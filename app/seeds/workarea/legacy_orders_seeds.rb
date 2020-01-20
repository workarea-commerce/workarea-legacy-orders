module Workarea
  class LegacyOrdersSeeds
    def perform
      puts "Adding legacy orders..."

      users.each do |user|
        rand(1..5).times {  Workarea::LegacyOrder.create!(order(user)) }
      end

      10.times { Workarea::LegacyOrder.create!(order) }
    end

    private

    def users
      (
        Workarea::User.all.sample(4) +
        [Workarea::User.find_by_email("user@workarea.com")]
      ).uniq.compact
    end

    def order(user = nil)
      email = user&.email || Faker::Internet.email
      items = rand(1..5).times.map { item }

      shipping = Faker::Commerce.price.to_m
      discount = [0, nil, -1 * Faker::Commerce.price.to_m].sample
      tax = Faker::Commerce.price.to_m

      total = items.sum { |i| i[:price] } + shipping + tax + discount.to_m

      {
        email: email,
        customer_number: user&.id,
        alternate_number: SecureRandom.hex(5).upcase,
        placed_at: Faker::Date.between(from: 3.years.ago, to: Date.today),
        status: "Shipped",
        shipping_method: "USPS Ground",
        shipping_total: shipping,
        discount_total: discount,
        tax_total: tax,
        total_price: total,
        items: items,
        tenders: tenders(total),
        billing_address: address,
        shipping_address: address
      }
    end

    def tenders(total)
      tenders = []

      if Faker::Boolean.boolean
        tenders << {
          type: "Gift Card",
          number: Faker::Business.credit_card_number,
          amount: Faker::Commerce.price(range: 0..total.to_f).to_m
        }
      end

      tenders << {
        type: Faker::Business.credit_card_type,
        number: Faker::Business.credit_card_number,
        amount: total - (tenders.sum { |t| t[:amount] } || 0).to_m,
        expiration_month: Faker::Business.credit_card_expiry_date.month,
        expiration_year: Faker::Business.credit_card_expiry_date.year
      }
    end

    def item
      item = {
        name: Faker::Commerce.product_name,
        sku: Faker::Code.isbn,
        quantity: rand(1..8),
        price: Faker::Commerce.price.to_m,
        status: item_status.sample
      }
      if Faker::Boolean.boolean
        item[:details] = {
          color: Faker::Commerce.color,
          size: "medium"
        }
      end

      if Faker::Boolean.boolean
        item[:customizations] = {
          line_1: Faker::Hipster.words.join(" "),
          line_2: Faker::Hipster.words.join(" ")
        }
      end

      item
    end

    def address
      {
        name: Faker::Name.name,
        street: Faker::Address.street_address,
        street_2: Faker::Address.secondary_address,
        city: Faker::Address.city,
        region: Faker::Address.state_abbr,
        postal_code: Faker::Address.zip,
        country: Faker::Address.country_code,
        phone_number: Faker::PhoneNumber.phone_number
      }
    end

    def item_status
      @item_status = [*%w(shipping) * 9, nil, 'pending', 'canceled']
    end
  end
end
