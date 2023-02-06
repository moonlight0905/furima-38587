FactoryBot.define do
  factory :purchase_destination do
    postal_code { '123-4567' }
    prefecture_id { 10 }
    locality { 'テスト市' }
    address { '1' }
    building_name { 'テストマンション101' }
    phone { '09012345678' }
    purchase_id { 10 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
