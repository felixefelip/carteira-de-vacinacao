# typed: true

# Parece que não é usado essa action
module Views::Doses
  class Form < Views::Base
    extend T::Sig

    sig { params(dose: Dose, vacina: Vacina).void }
    def initialize(dose:, vacina:)
      super()
      self.dose = dose
      self.vacina = vacina
    end

    def view_template
      form_with model: @dose, url: vacina_doses_path do |form|
        if @dose.errors.any?
          div id: "error_explanation" do
            h2 { "#{helpers.pluralize(@dose.errors.count, 'error')} prohibited this dose from being saved:" }
            ul do
              @dose.errors.each do |error|
                li { error.full_message }
              end
            end
          end
        end

        div class: "form-group" do
          form.label :fabricante_vacina
          form.collection_select :fabricante_vacina_id, @vacina.fabricante_vacinas.all, :id, :descricao, {}, class: "form-control"
        end

        div class: "form-group" do
          form.label :data_vacinacao
          form.date_field :data_vacinacao, class: "form-control"
        end

        div class: "form-group" do
          form.label :lote_numero
          form.text_field :lote_numero, class: "form-control"
        end

        div class: "form-group" do
          form.label :vacinador_codigo
          form.text_field :vacinador_codigo, class: "form-control"
        end

        div class: "form-group" do
          form.label :local_codigo
          form.text_field :local_codigo, class: "form-control"
        end

        div class: "actions" do
          form.submit "Salvar", class: "btn btn-primary"
          link_to "Voltar", :back
        end
      end
    end

    private

    sig { returns(Vacina) }
    attr_accessor :vacina

    sig { returns(Dose) }
    attr_accessor :dose
  end
end
