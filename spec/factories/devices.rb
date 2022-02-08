FactoryBot.define do
  factory :device do
    uuid { SecureRandom.uuid }
  end
end
