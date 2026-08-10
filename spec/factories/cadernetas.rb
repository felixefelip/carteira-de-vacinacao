FactoryBot.define do
  factory :caderneta, class: 'Caderneta' do
    skip_create
    initialize_with { association(:pessoa).caderneta }
  end
end
