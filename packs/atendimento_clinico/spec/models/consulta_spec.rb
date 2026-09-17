require 'rails_helper'

RSpec.describe Consulta, type: :model do
  describe 'associations' do
    it { should belong_to(:pessoa).required }
    it { should belong_to(:agendamento).optional }
    it { should have_many(:prescricoes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:motivo) }
    it { should validate_presence_of(:realizada_em) }

    it 'aceita somente um registro por agendamento', :aggregate_failures do
      agendamento = FactoryBot.create(:agendamento)
      FactoryBot.create(:consulta, pessoa: agendamento.pessoa, agendamento:)

      outra_consulta = FactoryBot.build(:consulta, pessoa: agendamento.pessoa, agendamento:)

      expect(outra_consulta).to be_invalid
      expect(outra_consulta.errors[:agendamento_id]).to be_present
    end

    it 'exige que o agendamento pertença à mesma pessoa', :aggregate_failures do
      consulta = FactoryBot.build(
        :consulta,
        pessoa: FactoryBot.create(:pessoa),
        agendamento: FactoryBot.create(:agendamento),
      )

      expect(consulta).to be_invalid
      expect(consulta.errors[:agendamento]).to include('precisa pertencer à mesma pessoa')
    end
  end

  it 'marca o agendamento vinculado como realizado ao ser registrada' do
    agendamento = FactoryBot.create(:agendamento, status: :agendado)

    FactoryBot.create(:consulta, pessoa: agendamento.pessoa, agendamento:)

    expect(agendamento.reload).to be_realizado
  end
end
