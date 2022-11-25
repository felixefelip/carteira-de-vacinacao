class AddOrdemNoCalendarioToVacina < ActiveRecord::Migration[6.1]
  def change
    add_column :vacinas, :ordem_no_calendario, :integer
  end
end
