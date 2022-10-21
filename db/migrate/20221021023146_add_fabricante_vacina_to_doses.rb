class AddFabricanteVacinaToDoses < ActiveRecord::Migration[6.1]
  def change
    add_reference :doses, :fabricante_vacina, null: false, foreign_key: true
    remove_reference :doses, :vacina
  end
end
