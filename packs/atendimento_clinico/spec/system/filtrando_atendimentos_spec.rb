require 'rails_helper'
require 'capybara/rspec'

describe 'Filtrando atendimentos', type: :feature do
  let(:cenario) do
    cardiologia = FactoryBot.create(:especialidade, nome: 'Cardiologia')
    neurologia = FactoryBot.create(:especialidade, nome: 'Neurologia')
    {
      user: FactoryBot.create(:user),
      cardiologista: FactoryBot.create(:profissional, nome: 'Dra. Ana', especialidade: cardiologia),
      neurologista: FactoryBot.create(:profissional, nome: 'Dr. Caio', especialidade: neurologia),
      clinica: FactoryBot.create(:estabelecimento, nome: 'Clínica Central'),
      hospital: FactoryBot.create(:estabelecimento, nome: 'Hospital Municipal'),
    }
  end

  before { entra_na_conta }

  it 'filtra agendamentos por período, cadastros clínicos, situação e pagamento', :aggregate_failures do
    cria_agendamentos
    visit agendamentos_path

    preenche_periodo
    select 'Dra. Ana · Cardiologia', from: 'Profissional'
    select 'Cardiologia', from: 'Especialidade'
    select 'Clínica Central', from: 'Estabelecimento'
    select 'Realizado', from: 'Situação'
    select 'Pago', from: 'Pagamento'
    click_button 'Filtrar'

    expect(page).to have_content 'Retorno cardiológico'
    expect(page).to have_no_content 'Avaliação neurológica'
    expect(page).to have_link 'Limpar filtros'

    click_link 'Limpar filtros'
    expect(page).to have_content('Retorno cardiológico').and have_content('Avaliação neurológica')
  end

  it 'filtra consultas por período, profissional, especialidade e estabelecimento', :aggregate_failures do
    cria_consultas
    visit consultas_path

    preenche_periodo
    select 'Dra. Ana · Cardiologia', from: 'Profissional'
    select 'Cardiologia', from: 'Especialidade'
    select 'Clínica Central', from: 'Estabelecimento'
    click_button 'Filtrar'

    expect(page).to have_content 'Consulta cardiológica'
    expect(page).to have_no_content 'Consulta neurológica'
    expect(page).to have_link 'Limpar filtros'
  end

  def cria_agendamentos
    cria_agendamento_cardiologico
    cria_agendamento_neurologico
  end

  def cria_agendamento_cardiologico
    FactoryBot.create(
      :agendamento,
      **referencias_cardiologicas,
      motivo: 'Retorno cardiológico',
      inicio_em: Time.zone.local(2026, 9, 20, 14),
      status: :realizado,
      pago_em: Date.new(2026, 9, 20),
    )
  end

  def cria_agendamento_neurologico
    FactoryBot.create(
      :agendamento,
      **referencias_neurologicas,
      motivo: 'Avaliação neurológica',
      inicio_em: Time.zone.local(2026, 10, 20, 14),
    )
  end

  def cria_consultas
    cria_consulta_cardiologica
    cria_consulta_neurologica
  end

  def cria_consulta_cardiologica
    FactoryBot.create(
      :consulta,
      **referencias_cardiologicas,
      motivo: 'Consulta cardiológica',
      realizada_em: Time.zone.local(2026, 9, 20, 14),
    )
  end

  def cria_consulta_neurologica
    FactoryBot.create(
      :consulta,
      **referencias_neurologicas,
      motivo: 'Consulta neurológica',
      realizada_em: Time.zone.local(2026, 10, 20, 14),
    )
  end

  def referencias_cardiologicas
    profissional = cenario.fetch(:cardiologista)
    { pessoa:, profissional:, especialidade: profissional.especialidade, estabelecimento: cenario.fetch(:clinica) }
  end

  def referencias_neurologicas
    profissional = cenario.fetch(:neurologista)
    { pessoa:, profissional:, especialidade: profissional.especialidade, estabelecimento: cenario.fetch(:hospital) }
  end

  def pessoa
    cenario.fetch(:user).pessoa_titular
  end

  def preenche_periodo
    fill_in 'Data inicial', with: '2026-09-01'
    fill_in 'Data final', with: '2026-09-30'
  end

  def entra_na_conta
    visit new_user_session_path
    fill_in 'E-mail', with: cenario.fetch(:user).email
    fill_in 'Senha', with: '123456'
    click_button 'Entrar'
  end
end
