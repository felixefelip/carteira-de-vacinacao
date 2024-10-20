class CreateFiscalNotaFiscalItems < ActiveRecord::Migration[7.1]
  def change
    create_table :fiscal_nota_fiscal_items do |t|
      t.decimal :icms_aliquota
      t.decimal :icms_valor
      t.decimal :icms_valor_base_de_calculo
      t.decimal :valor_unitario
      t.decimal :quantidade

      t.timestamps
    end
  end
end
