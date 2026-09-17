require 'rails_helper'
require 'capybara/rspec'

describe 'Gerenciando agendamentos', type: :feature do
  it 'cadastra um agendamento e registra sua realização e pagamento', :aggregate_failures do
    cadastra_a_conta
    cadastra_referencias_clinicas

    click_link 'Agendamentos'

    expect(page).to have_content 'Nenhum agendamento cadastrado para esta pessoa.'

    click_link 'Novo agendamento'

    fill_in 'Motivo do atendimento', with: 'Consulta de rotina'
    fill_in 'Data e horário', with: '2026-09-20T14:30'
    fill_in 'Duração em minutos', with: '60'
    select 'Dra. Ana · Cardiologia', from: 'Profissional'
    select 'Clínica Central', from: 'Estabelecimento'
    fill_in 'Valor', with: '250.00'
    anexa_avatar_e_comprovante
    click_button 'Criar Agendamento'

    expect(page).to have_content 'Agendamento cadastrado com sucesso.'
    expect(page).to have_content 'Consulta de rotina'
    expect(page).to have_content 'Cardiologia · Dra. Ana · Clínica Central'
    expect(page).to have_content 'R$ 250,00'
    expect(page).to have_content 'Agendado'
    expect(page).to have_content 'Não pago'
    expect(page).to have_link('avatar.png').and have_link('comprovante.pdf')

    click_link 'Editar'
    select 'Realizado', from: 'Situação'
    fill_in 'Pago em', with: '2026-09-20'
    attach_file 'Anexos', Rails.root.join('spec/fixtures/files/pedido-medico.pdf')
    click_button 'Atualizar Agendamento'

    expect(page).to have_content 'Agendamento atualizado com sucesso.'
    expect(page).to have_content 'Realizado'
    expect(page).to have_content 'Pago'

    agendamento = Agendamento.find_by!(motivo: 'Consulta de rotina')
    expect(agendamento.pessoa).to eq(User.last.pessoa_titular)
    expect(agendamento).to have_attributes(valor: 250, pago_em: Date.new(2026, 9, 20))
    expect(agendamento.anexos.map { |anexo| anexo.filename.to_s })
      .to match_array(%w[avatar.png comprovante.pdf pedido-medico.pdf])

    FactoryBot.create(:pessoa, user: User.last, nome: 'João')

    click_link 'Pessoas'
    within('tr', text: 'João') { click_button 'Ver caderneta' }
    click_link 'Agendamentos'

    expect(page).to have_content 'Agendamentos de João'
    expect(page).to have_content 'Nenhum agendamento cadastrado para esta pessoa.'
    expect(page).to have_no_content 'Consulta de rotina'
  end

  def anexa_avatar_e_comprovante
    attach_file 'Anexos', [
      Rails.root.join('spec/fixtures/files/avatar.png'),
      Rails.root.join('spec/fixtures/files/comprovante.pdf'),
    ]
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
    FactoryBot.create(:profissional, nome: 'Dra. Ana', especialidade:)
    FactoryBot.create(:estabelecimento, nome: 'Clínica Central')
  end
end
