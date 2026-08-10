class RemoveDataNascimentoFromUsers < ActiveRecord::Migration[8.0]
  # A data de nascimento agora é da pessoa, não da conta: a conta pode
  # administrar várias pessoas e nenhuma delas é "a data do login".
  def change
    remove_column :users, :data_nascimento, :date
  end
end
