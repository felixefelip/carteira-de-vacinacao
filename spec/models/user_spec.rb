require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { should have_one(:caderneta).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:data_nascimento) }
    it { should validate_comparison_of(:data_nascimento).is_less_than(Date.current).with_message('não pode ser no futuro') }
  end
end
