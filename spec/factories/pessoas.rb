FactoryBot.define do
  factory :pessoa do
    nome { 'Maria Silva' }
    data_nascimento { Date.new(2022, 1, 1) }
    user
  end
end
