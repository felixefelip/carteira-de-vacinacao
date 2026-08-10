FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { '123456' }
    pessoa_titular_attributes { { nome: 'Pessoa Titular', data_nascimento: Date.new(2022, 1, 1) } }
  end
end
