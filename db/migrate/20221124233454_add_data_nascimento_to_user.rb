class AddDataNascimentoToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :data_nascimento, :date
  end
end
