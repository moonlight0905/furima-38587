FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    family_name { person.last.kanji }
    family_name_kana { person.last.katakana }
    first_name { person.first.kanji }
    first_name_kana { person.first.katakana }
    birthday { Faker::Date.birthday(min_age: 5, max_age: 93) }
  end
end
