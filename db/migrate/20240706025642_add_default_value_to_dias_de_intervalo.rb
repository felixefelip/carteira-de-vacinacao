class AddDefaultValueToDiasDeIntervalo < ActiveRecord::Migration[6.1]
  def change
    change_column :vacinas, :dias_de_intervalo, :integer, default: 0, nil: false
  end
end
