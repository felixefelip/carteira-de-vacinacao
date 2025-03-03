# typed: true

module RecomendacaoVacina
  class Cadastrar
    extend T::Sig

    sig { params(record: RecomendacaoVacina::Record).void }
    def initialize(record)
      self.record = record
    end

    sig { returns(Array) }
    def call
      id = 1 # record.id || raise('RecomendacaoVacina sem id')
      if record.invalid?
        return [:invalid, { errors: record.errors }]
      end

      recomendacao = record.recomendacao || raise('RecomendacaoVacina sem recomendacao')
      vacina = record.vacina || raise('RecomendacaoVacina sem vacina')

      entity = RecomendacaoVacina::Entity.new(id:, recomendacao:, vacina:,
                                              status_vacinal: nil)

      record.status_vacinal = entity.status_vacinal

      record.save!

      [:success, entity]
    end

    private

    sig { returns(RecomendacaoVacina::Record) }
    attr_accessor :record
  end
end
