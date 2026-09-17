require 'rails_helper'

RSpec.describe Agendamento, type: :model do
  describe 'associations' do
    it { should belong_to(:pessoa).required }
  end

  describe 'validations' do
    it { should validate_presence_of(:motivo) }
    it { should validate_presence_of(:inicio_em) }
    it { should validate_numericality_of(:duracao_minutos).only_integer.is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:valor).is_greater_than_or_equal_to(0).allow_nil }

    it 'aceita apenas as situações conhecidas', :aggregate_failures do
      agendamento = FactoryBot.build(:agendamento, status: 'desconhecido')

      expect(agendamento).to be_invalid
      expect(agendamento.errors[:status]).to be_present
    end
  end

  describe '#pago?' do
    it 'indica pagamento somente quando há uma data registrada', :aggregate_failures do
      expect(FactoryBot.build(:agendamento, pago_em: nil)).not_to be_pago
      expect(FactoryBot.build(:agendamento, pago_em: Date.current)).to be_pago
    end
  end

  describe 'anexos', :aggregate_failures do
    it 'aceita imagens e PDFs' do
      agendamento = FactoryBot.build(:agendamento)
      agendamento.anexos.attach(
        { io: StringIO.new('imagem'), filename: 'imagem.png', content_type: 'image/png' },
        { io: StringIO.new('%PDF-1.4'), filename: 'documento.pdf', content_type: 'application/pdf' },
      )

      expect(agendamento).to be_valid
      expect(agendamento.anexos.size).to eq(2)
    end

    it 'recusa outros tipos de arquivo' do
      agendamento = FactoryBot.build(:agendamento)
      agendamento.anexos.attach(io: StringIO.new('texto'), filename: 'texto.txt', content_type: 'text/plain')

      expect(agendamento).to be_invalid
      expect(agendamento.errors.full_messages).to include(
        'Anexos texto.txt precisa ser PDF, PNG, JPEG ou WEBP',
      )
    end

    it 'recusa arquivos acima do tamanho máximo' do
      agendamento = FactoryBot.build(:agendamento)
      conteudo = StringIO.new('x' * (Agendamento::TAMANHO_MAXIMO_DO_ANEXO + 1))
      agendamento.anexos.attach(io: conteudo, filename: 'grande.pdf', content_type: 'application/pdf')

      expect(agendamento).to be_invalid
      expect(agendamento.errors.full_messages).to include(
        'Anexos grande.pdf precisa ter no máximo 10 MB',
      )
    end
  end
end
