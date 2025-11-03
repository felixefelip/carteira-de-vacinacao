require 'rails_helper'
require 'capybara/rspec'

describe 'Cadastrando uma nova dose', type: :feature do
  it 'cadastra o usuário', :aggregate_failures do
    # Capybara.current_driver = :selenium_chrome
    CadastraVacinasPadrao.call

    visit '/users/sign_up'

    within('#new_user') do
      fill_in 'E-mail', with: 'user@example.com'
      fill_in 'Data de Nascimento', with: '01/01/2000'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_button 'Cadastrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.'

    click_link 'Calendário'

    bcg_row = page.find('tr', text: 'BCG')
    expect(bcg_row).to be_present

    within(bcg_row) do
      click_link 'Cadastrar dose'
    end

    expect(page).to have_content 'Nova Dose'
    click_button 'Salvar'

    expect(page).to have_content 'Dose cadastrada com sucesso.'

    bcg_row_cadastrada = page.find('tr', text: 'BCG')
    bcg_row_cadastrada.find('td', text: '1 doses')

    within(bcg_row_cadastrada) do
      click_link 'BCG'
    end

    expect(page).to have_content 'Doses tomadas da vacina BCG'

    expect(page).to have_content '1 doses'
  end
end
