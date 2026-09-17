require 'rails_helper'
require 'capybara/rspec'

describe 'Gerenciando consultas', type: :feature do
  it 'registra uma consulta a partir de um agendamento e mantém seus anexos', :aggregate_failures do
    cadastra_a_conta
    profissional, especialidade, estabelecimento = cadastra_referencias_clinicas
    agendamento = FactoryBot.create(
      :agendamento,
      pessoa: User.last.pessoa_titular,
      motivo: 'Consulta cardiológica',
      inicio_em: Time.zone.local(2026, 9, 20, 14, 30),
      especialidade:,
      profissional:,
      estabelecimento:,
    )

    click_link 'Agendamentos'
    click_link 'Registrar consulta'

    expect(page).to have_content 'Esta consulta será vinculada ao agendamento de 20 de setembro, 14:30.'
    expect(page).to have_field('Motivo da consulta', with: 'Consulta cardiológica')
    expect(page).to have_select('Especialidade', selected: 'Cardiologia')

    fill_in 'Resumo clínico', with: 'Paciente em bom estado geral.'
    fill_in 'Orientações', with: 'Retornar em seis meses.'
    attach_file 'Anexos', [
      Rails.root.join('spec/fixtures/files/comprovante.pdf'),
      Rails.root.join('spec/fixtures/files/avatar.png'),
    ]
    click_button 'Criar Consulta'

    expect(page).to have_content 'Consulta registrada com sucesso.'
    expect(page).to have_content 'Consulta cardiológica'
    expect(page).to have_content 'Paciente em bom estado geral.'
    expect(page).to have_link('comprovante.pdf').and have_link('avatar.png')
    expect(agendamento.reload).to be_realizado

    click_link 'Editar'
    attach_file 'Anexos', Rails.root.join('spec/fixtures/files/pedido-medico.pdf')
    click_button 'Atualizar Consulta'

    consulta = Consulta.find_by!(motivo: 'Consulta cardiológica')
    expect(consulta.anexos.map { |anexo| anexo.filename.to_s })
      .to match_array(%w[avatar.png comprovante.pdf pedido-medico.pdf])

    visit new_consulta_path(agendamento_id: agendamento)
    expect(page).to have_content 'Editar consulta'

    click_link 'Agendamentos'
    expect(page).to have_content 'Realizado'
    expect(page).to have_link 'Ver consulta'
  end

  it 'permite registrar uma consulta sem agendamento e a isola por pessoa', :aggregate_failures do
    cadastra_a_conta

    click_link 'Consultas'
    expect(page).to have_content 'Nenhuma consulta registrada para esta pessoa.'

    click_link 'Registrar consulta'
    fill_in 'Motivo da consulta', with: 'Atendimento anterior'
    fill_in 'Data e horário', with: '2026-08-10T09:00'
    click_button 'Criar Consulta'

    expect(page).to have_content 'Atendimento anterior'
    expect(Consulta.last.agendamento).to be_nil

    FactoryBot.create(:pessoa, user: User.last, nome: 'João')
    click_link 'Pessoas'
    within('tr', text: 'João') { click_button 'Ver caderneta' }
    click_link 'Consultas'

    expect(page).to have_content 'Consultas de João'
    expect(page).to have_content 'Nenhuma consulta registrada para esta pessoa.'
    expect(page).to have_no_content 'Atendimento anterior'
  end

  def cadastra_a_conta
    visit '/users/sign_up'

    within('#new_user') do
      fill_in 'E-mail', with: 'paciente@example.com'
      fill_in 'Seu nome', with: 'Felipe'
      fill_in 'Sua data de nascimento', with: '01/01/1990'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_button 'Cadastrar'
    end
  end

  def cadastra_referencias_clinicas
    especialidade = FactoryBot.create(:especialidade, nome: 'Cardiologia')
    profissional = FactoryBot.create(:profissional, nome: 'Dra. Ana', especialidade:)
    estabelecimento = FactoryBot.create(:estabelecimento, nome: 'Clínica Central')
    [profissional, especialidade, estabelecimento]
  end
end
