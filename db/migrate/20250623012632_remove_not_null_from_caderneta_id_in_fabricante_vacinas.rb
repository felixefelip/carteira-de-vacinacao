class RemoveNotNullFromCadernetaIdInFabricanteVacinas < ActiveRecord::Migration[8.0]
  def change
    change_column_null :fabricante_vacinas, :caderneta_id, true
  end
end
