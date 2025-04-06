require 'capybara/rspec'
require_relative '../../lib/vacina/cadastra_vacinas_padrao'

describe 'Cadastrando usuário e criando caderneta automaticamente', type: :feature do
  it 'cadastra o usuário', :aggregate_failures do
    Vacina::CadastraVacinasPadrao.call

    visit '/users/sign_up'

    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Data nascimento', with: '01/01/2000'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
    end

    expect(page).to have_content 'Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.'

    click_link 'Calendário'

    expect(page).to have_content 'Hepatite B recombinante'
    expect(page).to have_content 'disponivel'

    recomendacoes_de_vacinas = User::Record.last.recomendacao_vacinas
    recomendacao_vacina = recomendacoes_de_vacinas.first

    # save_and_open_page
    expect(recomendacoes_de_vacinas.count).to eq(3)
    expect(recomendacao_vacina.status_vacinal).to eq('disponivel')

    expect(recomendacao_vacina.quando_pode_tomar_proxima_dose).to be_nil #eq(Date.current)
  end
end
