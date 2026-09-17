FactoryBot.define do
  factory :estabelecimento do
    sequence(:nome) { |numero| "Clínica #{numero}" }
  end
end
