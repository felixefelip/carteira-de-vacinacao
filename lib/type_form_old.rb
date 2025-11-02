# typed: true

class Box
  extend T::Sig
  extend T::Generic # Provides `type_member` helper

  Elem = type_member # Makes the `Box` class generic

  # References the class-level generic `Elem`
  sig { params(val: Elem).void }
  def initialize(val:) = @val = val

  sig { returns(Elem) }
  attr_reader :val
end

int_box = Box[Integer].new(val: 1)
# T.reveal_type(int_box) # `Box[Integer]`

# T.reveal_type(int_box.val) # `Integer`

# int_box.val += 1

class Dose::Attributes < T::Enum
  enums do
    FabricanteVacinaId = new(:fabricante_vacina_id)
    DataVacinacao = new(:data_vacinacao)
    LoteNumero = new(:lote_numero)
    VacinadorCodigo = new(:vacinador_codigo)
    LocalCodigo = new(:local_codigo)
  end
end

class VacinaFormAttribute < T::Enum
  enums do
    Descricao = new(:descricao)
    QtdeDoses = new(:qtde_doses)
    IntervaloEntreDoses = new(:intervalo_entre_doses)
  end
end

class FormTypedOld
  extend T::Sig
  extend T::Generic # Provides `type_member` helper

  # Restringe Elem para aceitar apenas tipos que herdam de T::Enum
  Elem = type_member { { upper: T::Enum } }

  #: (attribute: Elem, klass: String) -> String
  def text_field(attribute:, klass:)
    "
			<input type='text' name='dose[#{attribute.serialize}]' class='#{klass}' value=''>
		"
  end

  #: (attribute: Elem, klass: String) -> String
  def date_field(attribute:, klass:)
    "
			<input type='date' name='dose[#{attribute.serialize}]' class='#{klass}' value=''>
		"
  end

  # Método para trabalhar com labels de formulário
  sig { params(attribute: Elem, text: T.nilable(String)).returns(String) }
  def label(attribute, text: nil)
    label_text = text || attribute.serialize.to_s.humanize
    "<label for='dose_#{attribute.serialize}'>#{label_text}</label>"
  end

  #: (Elem, Array, Symbol, Symbol, Hash[untyped, untyped], Hash) -> String
  def collection_select(attribute, collection, value_method, text_method, options = {}, html_options = {})
    options[:class] ||= 'form-control'
    options[:id] ||= "dose_#{attribute.serialize}"

    select_tag(
      "dose[#{attribute.serialize}]",
      options_for_select(collection.map { |item| [item.send(text_method), item.send(value_method)] }),
      options.merge(html_options),
    )
  end
end

form = FormTypedOld[Dose::Attributes].new

form.text_field(attribute: Dose::Attributes::DataVacinacao, klass: 'form-control')
