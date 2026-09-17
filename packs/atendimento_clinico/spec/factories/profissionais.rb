FactoryBot.define do
  factory :profissional do
    sequence(:nome) { |numero| "Profissional #{numero}" }
    especialidade
  end
end
