# typed: true

module Views::Doses
  class New < Phlex::HTML
    extend T::Sig

    #: (dose: Dose, vacina: Vacina) -> void
    def initialize(dose:, vacina:)
      super()
      self.dose = dose
      self.vacina = vacina
    end

    def view_template
      div class: 'row mt-4' do
        div class: 'col-10 col-lg-10 mx-auto' do
          h1 { 'Nova Dose' }
          render Form.new(dose, vacina)
        end
      end
    end

    private

    #: Dose
    attr_accessor :dose

    #: Vacina
    attr_accessor :vacina
  end
end
