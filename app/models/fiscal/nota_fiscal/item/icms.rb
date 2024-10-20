class Fiscal::NotaFiscal::Item::Icms
  include ActiveModel::Validations

  attr_reader :icms_aliquota, :icms_valor, :icms_valor_base_de_calculo

  validates :icms_aliquota, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :icms_valor, :icms_valor_base_de_calculo, numericality: { greater_than_or_equal_to: 0 }

  def initialize(icms_aliquota, icms_valor, icms_valor_base_de_calculo)
    @icms_aliquota = icms_aliquota
    @icms_valor = icms_valor
    @icms_valor_base_de_calculo = icms_valor_base_de_calculo
  end
end
