class MoveCadernetaDoUserParaPessoa < ActiveRecord::Migration[8.0]
  class User < ActiveRecord::Base
    self.table_name = 'users'
  end

  class Pessoa < ActiveRecord::Base
    self.table_name = 'pessoas'
  end

  class Caderneta < ActiveRecord::Base
    self.table_name = 'cadernetas'
  end

  def up
    add_reference :cadernetas, :pessoa, foreign_key: true

    criar_pessoa_titular_para_cada_conta

    change_column_null :cadernetas, :pessoa_id, false
    remove_reference :cadernetas, :user, foreign_key: true
  end

  def down
    add_reference :cadernetas, :user, foreign_key: true

    devolver_cadernetas_para_as_contas

    change_column_null :cadernetas, :user_id, false
    remove_reference :cadernetas, :pessoa, foreign_key: true
  end

  private

  def criar_pessoa_titular_para_cada_conta
    [Pessoa, Caderneta].each(&:reset_column_information)

    User.find_each do |user|
      raise "User ##{user.id} está sem data_nascimento; preencha antes de migrar." if user.data_nascimento.nil?

      pessoa = Pessoa.create!(user_id: user.id, titular: true, email: user.email,
                              nome: nome_a_partir_do_email(user.email),
                              data_nascimento: user.data_nascimento)

      Caderneta.where(user_id: user.id).update_all(pessoa_id: pessoa.id)
    end
  end

  def devolver_cadernetas_para_as_contas
    [Pessoa, Caderneta].each(&:reset_column_information)

    Caderneta.find_each do |caderneta|
      pessoa = Pessoa.find(caderneta.pessoa_id)
      raise ActiveRecord::IrreversibleMigration, 'há caderneta de pessoa não titular' unless pessoa.titular

      caderneta.update_columns(user_id: pessoa.user_id)
    end
  end

  def nome_a_partir_do_email(email)
    email.split('@').first.tr('._-', ' ').split.map(&:capitalize).join(' ')
  end
end
