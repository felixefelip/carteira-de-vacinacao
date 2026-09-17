require 'rails_helper'
require 'capybara/rspec'

describe 'Gerenciando agendamentos', type: :feature do
  it 'cadastra um agendamento e registra sua realização e pagamento', :aggregate_failures do
    cadastra_a_conta

    click_link 'Agendamentos'

    expect(page).to have_content 'Nenhum agendamento cadastrado para esta pessoa.'

    click_link 'Novo agendamento'

    fill_in 'Motivo do atendimento', with: 'Consulta de rotina'
    fill_in 'Data e horário', with: '2026-09-20T14:30'
    fill_in 'Duração em minutos', with: '60'
    fill_in 'Especialidade', with: 'Cardiologia'
    fill_in 'Profissional', with: 'Dra. Ana'
    fill_in 'Estabelecimento', with: 'Clínica Central'
    fill_in 'Valor', with: '250.00'
    click_button 'Criar Agendamento'

    expect(page).to have_content 'Agendamento cadastrado com sucesso.'
    expect(page).to have_content 'Consulta de rotina'
    expect(page).to have_content 'Cardiologia · Dra. Ana · Clínica Central'
    expect(page).to have_content 'R$ 250,00'
    expect(page).to have_content 'Agendado'
    expect(page).to have_content 'Não pago'

    click_link 'Editar'
    select 'Realizado', from: 'Situação'
    fill_in 'Pago em', with: '2026-09-20'
    click_button 'Atualizar Agendamento'

    expect(page).to have_content 'Agendamento atualizado com sucesso.'
    expect(page).to have_content 'Realizado'
    expect(page).to have_content 'Pago'

    agendamento = Agendamento.find_by!(motivo: 'Consulta de rotina')
    expect(agendamento.pessoa).to eq(User.last.pessoa_titular)
    expect(agendamento.valor).to eq(250)
    expect(agendamento.pago_em).to eq(Date.new(2026, 9, 20))

    FactoryBot.create(:pessoa, user: User.last, nome: 'João')

    click_link 'Pessoas'
    within('tr', text: 'João') { click_button 'Ver caderneta' }
    click_link 'Agendamentos'

    expect(page).to have_content 'Agendamentos de João'
    expect(page).to have_content 'Nenhum agendamento cadastrado para esta pessoa.'
    expect(page).to have_no_content 'Consulta de rotina'
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
