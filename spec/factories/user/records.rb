FactoryBot.define do
  factory :user_record, class: 'User::Record' do
    email { 'user@example.com' }
    data_nascimento { Date.new(2022, 1, 1) }
  end
end
