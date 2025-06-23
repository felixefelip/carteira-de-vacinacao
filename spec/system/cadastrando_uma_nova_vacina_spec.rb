require 'rails_helper'
require 'capybara/rspec'

describe 'Cadastrando uma nova vacina', type: :feature do
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

    click_link 'Vacinas'
    expect(page).to have_content 'Escolha uma vacina'

    bcg_row = page.find('tr', text: 'BCG')
    expect(bcg_row).to be_present

    click_link 'Criar Vacina'
    expect(page).to have_content 'Nova Vacina'

    fill_in 'Descricao', with: 'Pfizer'
    click_button 'Criar Vacina'

    expect(page).to have_content 'Vacina foi criada com sucesso'

    expect(page).to have_content 'Escolha uma vacina'

    page.find('tr', text: 'Pfizer')
  end
end
