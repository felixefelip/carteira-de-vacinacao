require 'rails_helper'

RSpec.describe RecomendacaoVacina do
  describe 'associations' do
    it { should have_one(:user) }
    it { should belong_to(:vacina) }
  end

  describe 'enums' do
    it { should define_enum_for(:status_vacinal).with_values(aguardando: 0, disponivel: 1, completo: 2) }
  end
end
