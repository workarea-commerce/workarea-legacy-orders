WebLinc Legacy Orders
================================================================================

Workarea Commerce platform plugin that enables the importing of orders from outside sources. Useful during the migration process from another system where you wish to preserve order data for customers.

Features
--------------------------------------------------------------------------------

* Display order history inline with Workarea order history for customers
* Supports order lookup behavior for guest orders
* Admin UI support for searching and browsing legacy orders
* Admin UI support for importing and exporting legacy orders
* Admin API Support for viewing legacy orders

Getting Started
--------------------------------------------------------------------------------

Add the gem to your application's Gemfile:

    # ...
    gem 'workarea-legacy_orders'
    # ...

Update your application's bundle.

    cd path/to/application
    bundle

Data Structure
--------------------------------------------------------------------------------

Legacy orders are structured to be a simplistic representation of order data as compared to real Workarea order data. This more basic data structure alleviates the need to recreate or work around missing data when importing from outside sources. A legacy order has its own model, with embedded documents for items, tenders, and addresses.

```ruby
Workarea::LegacyOrder.create(
  id: '012789',
  email: 'customer@gmail.com',
  customer_number: '0001031',
  alternate_number: 'PO-85201',
  placed_at: Time.parse('20/02/2020 20:20:20'),
  status: 'shipped',
  shipping_method: 'USPS Priority Mail',
  shipping_total: 14.82.to_m,
  tax_total: 8.94.to_m,
  discount_total: -5.to_m,
  total_price: 172.73.to_m,
  data: {
    tracking_number: '1Z0E85051951',
    promo_codes: ['5OFF'],
    token: 'b1946ac92492d2347c6235b4d2611184'
  },
  billing_address: {
    first_name: 'Robert',
    last_name: 'Clams',
    street: '22 South 3rd St.',
    street_2: 'Second Floor',
    city: 'Philadelphia',
    region: 'PA',
    postal_code: '19106',
    country: 'US'
  },
  shipping_address: {
    first_name: 'Robert',
    last_name: 'Clams',
    street: '22 South 3rd St.',
    street_2: 'Second Floor',
    city: 'Philadelphia',
    region: 'PA',
    postal_code: '19106',
    country: 'US'
  },
  items: [
    {
      name: 'Awesome T-Shirt',
      sku: 'ATS001',
      quantity: 1,
      price: 24.99.to_m,
      detail: {
        'Color' => 'Black',
        'Size' => 'Medium'
      },
      customizations: {
       'custom text' => 'Clever Saying Goes Here'
      },
      status: 'pending'
    },
    {
      name: 'Fancy Pants',
      sku: 'FP1337',
      product_id: '00815291',
      quantity: 2,
      price: 128.98.to_m,
      details: { 'Size' => '30x30' },
      status: 'shipped'
    }
  ],
  tenders: [
    {
      type: 'gift card',
      number: 'XXXXXXXX6681',
      amount: 50.to_m
    },
    {
      type: 'credit card',
      number: 'XXXXXXXXXXXX1212',
      amount: 122.73.to_m,
      issuer: 'visa',
      expiration_month: '11',
      expiration_year: '2022',
      data: { authorization_id: '1595263196681261473' }
    }
  ]
)
```

### `Workarea::LegacyOrder`

| Field |  |
|--|--|
|`_id` | To match a Workarea order, the ID of a    `LegacyOrder` represents the order number displayed across the site. |
|`email` | *Required*. The email address associated to the order. |
|`customer_number` | Used to store a reference to the customer that placed the order. When looking for legacy orders for a user, Workarea will look to match the user's ID with this number. |
|`alternate_number` | Allows for the storage of other reference numbers other than ID. |
|`placed_at` | *Required*. When the order was placed. |
|`status` | The overall status of the order. |
|`shipping_method` | The name of the shipping method that was used for the order. |
|`shipping_total` | The total cost of shipping for the order. |
|`tax_total` | *Required*. The total cost of tax for the order. |
|`discount_total` | The total value of discounts for the order. |
|`total_price` | *Required*. The total cost of the entire order, including tax, shipping, and discounts. |
|`data` | A hash field that can be used to store other relevant data that you wish to preserve from orders imported to Workarea. |
| `billing_address`| An embedded document of the order's billing address. See `Workarea::LegacyOrder::Address` below.|
| `shipping_address`| An embedded document of the order's shipping address. See `Workarea::LegacyOrder::Address` below.|
| `items`| An embedded collection of items for the order. See `Workarea::LegacyOrder::Item` below.|
| `tenders`| An embedded collection of payment methods used for the order. See `Workarea::LegacyOrder::Tender` below.|

### `Workarea::LegacyOrder::Item`

| Field |  |
|--|--|
| `name` | *Required*. The display name for the item. Often this will be the name of the product. |
| `sku` | *Required*. The unique identifier for the specific item. |
| `product_id` | The ID of the product. |
| `quantity` | *Required*. The quantity of this item that was purchased. |
| `price` | *Required*. The total price of the item. |
| `details` | A hash of options for the item. Often things like color and size. |
| `customizations` | A hash of values specified by the customer when being ordered, e.g. engravings. |
| `status` | The fulfillment status of the item. Can be any value, but suggested to be one of `pending`, `shipped`, or `canceled`. |
| `data` | A hash field that can be used to store other relevant data that you wish to preserve from the item imported to Workarea. |

### `Workarea::LegacyOrder::Tender`

| Field |  |
|--|--|
| `type` | *Required*. The type of tender used, e.g. credit card, gift card, paypal, etc. |
| `number` | A number associated to the payment method. For credit card this would be an obfuscated number with the last four digits. |
| `amount` | *Required*. The amount charged to this tender. |
| `issuer` | For credit cards, the issuer of the card. |
| `expiration_month` | For credit cards, the month of expiration. |
| `expiration_year` | For credit cards, the year of expiration. |
| `data` | A hash field that can be used to store other relevant data that you wish to preserve from the tender imported to Workarea. |

### `Workarea::LegacyOrder::Address`

Legacy order address fields match fields for all other addresses in Workarea. The only exception is that legacy order addresses are not validated and allow for any number of fields to be blank if information is not available.

* `first_name`
* `last_name`
* `street`
* `street_2`
* `city`
* `company`
* `region`
* `postal_code`
* `country`
* `phone_number`
* `phone_extension`


Workarea Platform Documentation
--------------------------------------------------------------------------------

See [https://developer.workarea.com](https://developer.workarea.com) for Workarea platform documentation.

License
--------------------------------------------------------------------------------

Workarea Shopify Migration is released under the [Business Software License](LICENSE)
