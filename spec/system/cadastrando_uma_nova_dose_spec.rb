require 'rails_helper'
require 'capybara/rspec'

describe 'Cadastrando uma nova dose', type: :feature do
  it 'cadastra o usuário', :aggregate_failures do
    # Capybara.current_driver = :selenium_chrome
    CadastraVacinasPadrao.call

    visit '/users/sign_up'

    within('#new_user') do
      fill_in 'E-mail', with: 'user@example.com'
      fill_in 'Data nascimento', with: '01/01/2000'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_button 'Sign up'
    end

    expect(page).to have_content 'Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.'

    click_link 'Calendário'

    expect(page).to have_content 'Hepatite B recombinante'
    expect(page).to have_content 'disponivel'

    recomendacoes_de_vacinas = User.last.caderneta!.recomendacao_vacinas
    recomendacao_vacina = recomendacoes_de_vacinas.first!

    # save_and_open_page
    expect(recomendacoes_de_vacinas.count).to eq(3)
    expect(recomendacao_vacina.status_vacinal).to eq('disponivel')

    expect(recomendacao_vacina.quando_pode_tomar_proxima_dose).to be_nil #eq(Date.current)

    # Encontrar um tr que tenha um td com conteúdo BCG
    bcg_row = page.find('tr', text: 'BCG')
    expect(bcg_row).to be_present

    # Dentro do tr encontrado, clicar no link "Cadastrar dose"
    within(bcg_row) do
      click_link 'Cadastrar dose'
    end

    expect(page).to have_content 'Nova Dose'
    click_button 'Salvar'

    expect(page).to have_content 'Dose cadastrada com sucesso.'

    bcg_row_cadastrada = page.find('tr', text: 'BCG')
    bcg_row_cadastrada.find('td', text: '1 doses')
  end
end
