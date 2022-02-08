FactoryBot.define do
  factory :reading do
    timestamp { 1.days.from_now.iso8601 }
    count { Faker::Number.number(digits: 2) }
    device
  end
end
