require 'rails_helper'

RSpec.describe Agendamento::Anexavel do
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
      conteudo = StringIO.new('x' * (Agendamento::Anexavel::TAMANHO_MAXIMO + 1))
      agendamento.anexos.attach(io: conteudo, filename: 'grande.pdf', content_type: 'application/pdf')

      expect(agendamento).to be_invalid
      expect(agendamento.errors.full_messages).to include(
        'Anexos grande.pdf precisa ter no máximo 10 MB',
      )
    end
  end
end
