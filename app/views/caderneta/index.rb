# typed: true

module Views::Caderneta
  class Index < ViewComponent::Base
    extend T::Sig

    #: (vacinas: Vacina::PrivateAssociationRelation) -> void
    def initialize(vacinas:)
      super()
      self.vacinas = vacinas
    end

    private

		#: Vacina::PrivateAssociationRelation
		attr_accessor :vacinas
  end
end
