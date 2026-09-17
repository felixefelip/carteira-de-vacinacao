require 'rails_helper'
require 'capybara/rspec'

describe 'Gerenciando prescrições', type: :feature do
  it 'cadastra um medicamento e acompanha o tratamento registrado na consulta', :aggregate_failures do
    travel_to Time.zone.local(2026, 9, 17, 10) do
      cadastra_a_conta
      FactoryBot.create(
        :consulta,
        pessoa: User.last.pessoa_titular,
        motivo: 'Acompanhamento da pressão',
        realizada_em: Time.zone.local(2026, 9, 16, 14),
        resumo: 'Pressão arterial acima da meta.',
      )

      cadastra_medicamento
      registra_prescricao

      expect(page).to have_content 'Prescrição registrada com sucesso.'
      expect(page).to have_content 'Losartana'
      expect(page).to have_content '1 comprimido pela manhã'
      expect(page).to have_content 'Em uso'

      click_link 'Tratamentos'
      expect(page).to have_content 'Tratamentos de Felipe'
      expect(page).to have_content 'Acompanhamento da pressão'
      expect(page).to have_content 'Em uso'

      within('tr', text: 'Losartana') { click_link 'Editar' }
      fill_in 'Término do tratamento', with: '2026-09-16'
      click_button 'Atualizar Prescrição'

      expect(page).to have_content 'Prescrição atualizada com sucesso.'
      expect(page).to have_content 'Encerrado'
    end
  end

  it 'isola os tratamentos pelo perfil ativo', :aggregate_failures do
    cadastra_a_conta
    consulta = FactoryBot.create(:consulta, pessoa: User.last.pessoa_titular)
    FactoryBot.create(:prescricao, consulta:, medicamento: FactoryBot.create(:medicamento))
    FactoryBot.create(:pessoa, user: User.last, nome: 'João')

    click_link 'Gerenciar pessoas', visible: :all
    within('tr', text: 'João') { click_button 'Ver caderneta' }
    click_link 'Consultas'
    click_link 'Tratamentos'

    expect(page).to have_content 'Tratamentos de João'
    expect(page).to have_content 'Nenhuma prescrição registrada.'
    expect(page).to have_no_content 'Losartana'
  end

  def cadastra_medicamento
    acessa_cadastro_de_medicamento_pela_prescricao
    preenche_medicamento

    expect(page).to have_content 'Medicamento cadastrado com sucesso.'
    expect(page).to have_content 'Nova prescrição'
  end

  def acessa_cadastro_de_medicamento_pela_prescricao
    click_link 'Consultas'
    click_link 'Ver consulta'
    expect(page).to have_content 'Pressão arterial acima da meta.'
    click_link 'Nova prescrição'
    expect(page).to have_content 'Cadastre o primeiro medicamento'
    click_link 'Cadastrar medicamento'
  end

  def preenche_medicamento
    fill_in 'Nome', with: 'Losartana'
    fill_in 'Princípio ativo', with: 'Losartana potássica'
    fill_in 'Apresentação ou concentração', with: 'Comprimido 50 mg'
    click_button 'Criar Medicamento'
  end

  def registra_prescricao
    select 'Losartana · Losartana potássica · Comprimido 50 mg', from: 'Medicamento'
    fill_in 'Posologia', with: '1 comprimido pela manhã'
    fill_in 'Via de administração', with: 'Via oral'
    fill_in 'Início do tratamento', with: '2026-09-10'
    fill_in 'Orientações', with: 'Aferir a pressão diariamente.'
    click_button 'Criar Prescrição'
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
