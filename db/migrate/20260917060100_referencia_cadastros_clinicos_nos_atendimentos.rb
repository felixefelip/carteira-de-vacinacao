module ReferenciaCadastrosClinicosDados
  def migrar_especialidades
    executar_insercao_distinta(:especialidades, :especialidade)
    preencher_referencia_por_nome(:especialidade)
  end

  def migrar_estabelecimentos
    executar_insercao_distinta(:estabelecimentos, :estabelecimento_nome)
    preencher_referencia_por_nome(:estabelecimento, coluna_texto: :estabelecimento_nome)
  end

  def migrar_profissionais
    execute sql_migracao_profissionais
  end

  def sql_migracao_profissionais
    <<~SQL.squish
      INSERT INTO profissionais (nome, especialidade_id, created_at, updated_at)
      SELECT DISTINCT BTRIM(profissional_nome), especialidade_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM (
        SELECT profissional_nome, especialidade_id FROM agendamentos UNION ALL
        SELECT profissional_nome, especialidade_id FROM consultas
      ) registros
      WHERE profissional_nome IS NOT NULL AND BTRIM(profissional_nome) <> ''
      ON CONFLICT (nome, especialidade_id) DO NOTHING
    SQL
  end

  def preencher_referencias
    %i[agendamentos consultas].each { |tabela| preencher_profissional(tabela) }
  end

  def preencher_profissional(tabela)
    execute <<~SQL.squish
      UPDATE #{tabela} atendimento
      SET profissional_id = profissional.id
      FROM profissionais profissional
      WHERE BTRIM(atendimento.profissional_nome) = profissional.nome
        AND atendimento.especialidade_id IS NOT DISTINCT FROM profissional.especialidade_id
    SQL
  end

  def executar_insercao_distinta(tabela_destino, coluna_origem)
    execute sql_insercao_distinta(tabela_destino, coluna_origem)
  end

  def sql_insercao_distinta(tabela_destino, coluna_origem)
    <<~SQL.squish
      INSERT INTO #{tabela_destino} (nome, created_at, updated_at)
      SELECT DISTINCT BTRIM(#{coluna_origem}), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM (
        SELECT #{coluna_origem} FROM agendamentos UNION ALL
        SELECT #{coluna_origem} FROM consultas
      ) registros
      WHERE #{coluna_origem} IS NOT NULL AND BTRIM(#{coluna_origem}) <> ''
      ON CONFLICT (nome) DO NOTHING
    SQL
  end

  def preencher_referencia_por_nome(referencia, coluna_texto: referencia)
    %i[agendamentos consultas].each { |tabela| preencher_cadastro(tabela, referencia, coluna_texto) }
  end

  def preencher_cadastro(tabela, referencia, coluna_texto)
    execute <<~SQL.squish
      UPDATE #{tabela} atendimento
      SET #{referencia}_id = cadastro.id
      FROM #{referencia.to_s.pluralize} cadastro
      WHERE BTRIM(atendimento.#{coluna_texto}) = cadastro.nome
    SQL
  end
end

class ReferenciaCadastrosClinicosNosAtendimentos < ActiveRecord::Migration[8.1]
  include ReferenciaCadastrosClinicosDados

  def up
    adicionar_referencias
    migrar_especialidades
    migrar_estabelecimentos
    migrar_profissionais
    preencher_referencias
    remover_textos
  end

  def down
    restaurar_textos
    preencher_textos
    remover_referencias
  end

  private

  def adicionar_referencias
    %i[agendamentos consultas].each do |tabela|
      add_reference tabela, :especialidade, foreign_key: true
      add_reference tabela, :profissional, foreign_key: true
      add_reference tabela, :estabelecimento, foreign_key: true
    end
  end

  def remover_textos
    %i[agendamentos consultas].each do |tabela|
      remove_column tabela, :especialidade, :string
      remove_column tabela, :profissional_nome, :string
      remove_column tabela, :estabelecimento_nome, :string
    end
  end

  def restaurar_textos
    %i[agendamentos consultas].each do |tabela|
      add_column tabela, :especialidade, :string
      add_column tabela, :profissional_nome, :string
      add_column tabela, :estabelecimento_nome, :string
    end
  end

  def preencher_textos
    %i[agendamentos consultas].each do |tabela|
      preencher_texto(tabela, :especialidade, :especialidades)
      preencher_texto(tabela, :profissional_nome, :profissionais, referencia: :profissional)
      preencher_texto(tabela, :estabelecimento_nome, :estabelecimentos, referencia: :estabelecimento)
    end
  end

  def preencher_texto(tabela, coluna, origem, referencia: coluna)
    execute <<~SQL.squish
      UPDATE #{tabela} atendimento
      SET #{coluna} = cadastro.nome
      FROM #{origem} cadastro
      WHERE atendimento.#{referencia}_id = cadastro.id
    SQL
  end

  def remover_referencias
    %i[agendamentos consultas].each do |tabela|
      remove_reference tabela, :profissional, foreign_key: true
      remove_reference tabela, :especialidade, foreign_key: true
      remove_reference tabela, :estabelecimento, foreign_key: true
    end
  end
end
