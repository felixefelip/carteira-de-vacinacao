class AddRelationsToCaderneta < ActiveRecord::Migration[8.0]
  def change
    add_belongs_to :recomendacao_vacinas, :caderneta, null: false
    add_belongs_to :fabricante_vacinas, :caderneta, null: false
    add_belongs_to :doses, :caderneta, null: false
  end
end
