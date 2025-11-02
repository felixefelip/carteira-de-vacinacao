# typed: true

# Parece que não é usado essa action
module Views::Doses
  class Form < Views::Base
    extend T::Sig

    #: (Dose, Vacina) -> void
    def initialize(dose, vacina)
      super()
      self.dose = dose
      self.vacina = vacina
    end

    def view_template
      form_with model: dose, url: vacina_doses_path do |form|
        form = T.let(form, FormTypedOld[Dose::Attributes])

        if dose.errors.any?
          div id: "error_explanation" do
            h2 { "#{helpers.pluralize(dose.errors.count, 'error')} prohibited this dose from being saved:" }
            ul do
              dose.errors.each do |error|
                li { error.full_message }
              end
            end
          end
        end

        div class: "form-group" do
          form.label Dose::Attributes::FabricanteVacinaId
          form.collection_select Dose::Attributes::FabricanteVacinaId, vacina.fabricante_vacinas.all, :id, :descricao, {}, class: "form-control"
        end

        div class: "form-group" do
          form.label Dose::Attributes::DataVacinacao
          form.date_field attribute: Dose::Attributes::DataVacinacao, klass: "form-control"
        end

        div class: "form-group" do
          form.label Dose::Attributes::LoteNumero
          form.text_field attribute: Dose::Attributes::LoteNumero, klass: "form-control"
        end

        div class: "form-group" do
          form.label Dose::Attributes::VacinadorCodigo
          form.text_field attribute: Dose::Attributes::VacinadorCodigo, klass: "form-control"
        end

        div class: "form-group" do
          form.label Dose::Attributes::LocalCodigo
          form.text_field attribute: Dose::Attributes::LocalCodigo, klass: "form-control"
        end

        div class: "actions" do
          form.submit "Salvar", class: "btn btn-primary"
          link_to "Voltar", :back
        end
      end
    end

    private

    #: Vacina
    attr_accessor :vacina

    #: Dose
    attr_accessor :dose
  end
end
