FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { '123456' }

    # A conta não existe sem a pessoa titular, e é por ela que passa o nome e a
    # data de nascimento — o mesmo caminho do formulário de cadastro.
    pessoa_titular_attributes { { nome: 'Pessoa Titular', data_nascimento: Date.new(2022, 1, 1) } }
  end
end
