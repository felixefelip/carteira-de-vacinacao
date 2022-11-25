class ChangeIdadeRecomendadaTypeToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :dose_do_calendarios, :idade_recomendada, :float
  end
end
