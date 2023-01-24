FactoryBot.define do
  factory :item do
    association :user
    
    item_name { Faker::Lorem.word  }
    text { Faker::Lorem.sentences(number: 3) }
    price { Faker::Number.between(from: 300, to: 9999999) }
    category_id { '1' }
    condition_id { '2' }
    shipping_cost_id { '3' }
    prefecture_id { '4' }
    days_to_ship_id { '1' }
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end  
  end
end
