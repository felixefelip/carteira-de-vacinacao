FactoryBot.define do
  factory :especialidade do
    sequence(:nome) { |numero| "Especialidade #{numero}" }
  end
end
