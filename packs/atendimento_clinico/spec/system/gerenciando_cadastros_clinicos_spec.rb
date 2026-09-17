require 'rails_helper'
require 'capybara/rspec'

describe 'Gerenciando cadastros clínicos', type: :feature do
  it 'vincula profissional, especialidade e estabelecimento ao atendimento', :aggregate_failures do
    cadastra_a_conta
    cadastra_especialidade
    cadastra_profissional
    cadastra_estabelecimento

    click_link 'Agendamentos'
    click_link 'Novo agendamento'

    opcao = find_field('Profissional').find('option', text: 'Dra. Ana · Cardiologia')
    expect(opcao['data-especialidade-id']).to eq(Especialidade.find_by!(nome: 'Cardiologia').id.to_s)
    expect(find_field('Especialidade')['data-profissional-especialidade-target']).to eq('especialidade')

    fill_in 'Motivo do atendimento', with: 'Consulta cardiológica'
    fill_in 'Data e horário', with: '2026-09-20T14:30'
    select 'Dra. Ana · Cardiologia', from: 'Profissional'
    select 'Clínica Central', from: 'Estabelecimento'
    click_button 'Criar Agendamento'

    agendamento = Agendamento.find_by!(motivo: 'Consulta cardiológica')
    expect(agendamento.profissional.nome).to eq('Dra. Ana')
    expect(agendamento.especialidade.nome).to eq('Cardiologia')
    expect(agendamento.estabelecimento.nome).to eq('Clínica Central')

    click_link 'Registrar consulta'
    expect(page).to have_select('Profissional', selected: 'Dra. Ana · Cardiologia')
    expect(page).to have_select('Especialidade', selected: 'Cardiologia')
    expect(page).to have_select('Estabelecimento', selected: 'Clínica Central')
  end

  def cadastra_especialidade
    click_link 'Agendamentos'
    click_link 'Cadastros clínicos'
    click_link 'Especialidades'
    click_link 'Cadastrar especialidade'
    fill_in 'Nome', with: 'Cardiologia'
    click_button 'Criar Especialidade'
  end

  def cadastra_profissional
    click_link 'Profissionais'
    click_link 'Cadastrar profissional'
    fill_in 'Nome', with: 'Dra. Ana'
    select 'Cardiologia', from: 'Especialidade'
    click_button 'Criar Profissional'
  end

  def cadastra_estabelecimento
    click_link 'Estabelecimentos'
    click_link 'Cadastrar estabelecimento'
    fill_in 'Nome', with: 'Clínica Central'
    click_button 'Criar Estabelecimento'
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
end
