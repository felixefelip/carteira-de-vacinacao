# typed: true

module Views::Doses
  class New < Phlex::HTML
    extend T::Sig
    # include Phlex::Rails::Helpers::FormWith

    sig { params(dose: Dose::Record).void }
    def initialize(dose:)
      super()
      @dose = dose
    end

    def view_template
      div class: 'row mt-4' do
        div class: 'col-10 col-lg-10 mx-auto' do
          h1 { 'Nova Dose' }
          render partial('form', dose:)
        end
      end
    end

    private

    sig { returns(Dose::Record) }
    attr_reader :dose
  end
end
