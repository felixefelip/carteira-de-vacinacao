# == Schema Information
#
# Table name: fiscal_nota_fiscal_items
#
#  id                         :bigint           not null, primary key
#  icms_aliquota              :decimal(, )
#  icms_valor                 :decimal(, )
#  icms_valor_base_de_calculo :decimal(, )
#  quantidade                 :decimal(, )
#  valor_unitario             :decimal(, )
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class Fiscal::NotaFiscal::Item < ApplicationRecord
  composed_of :icms, class_name: 'Fiscal::NotaFiscal::Item::Icms',
                     mapping: { icms_aliquota: :icms_aliquota, icms_valor: :icms_valor,
                                icms_valor_base_de_calculo: :icms_valor_base_de_calculo }

  validates_associated :icms
end
