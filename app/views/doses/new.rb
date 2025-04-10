# typed: true

module Views::Doses
  class New < Phlex::HTML
    extend T::Sig
    # include Phlex::Rails::Helpers::FormWith

    sig { params(dose: Dose, vacina: Vacina).void }
    def initialize(dose:, vacina:)
      super()
      self.dose = dose
      self.vacina = vacina
    end

    def view_template
      div class: 'row mt-4' do
        div class: 'col-10 col-lg-10 mx-auto' do
          h1 { 'Nova Dose' }
          render Form.new(dose: dose, vacina: vacina)
        end
      end
    end

    private

    sig { returns(Dose) }
    attr_accessor :dose

    sig { returns(Vacina) }
    attr_accessor :vacina
  end
end
