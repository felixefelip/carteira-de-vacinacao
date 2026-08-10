require 'rails_helper'
require 'capybara/rspec'

describe 'Cadastrando pessoas na conta', type: :feature do
  it 'cadastra um filho, alterna entre as cadernetas e exclui', :aggregate_failures do
    CadastraVacinasPadrao.call
    cadastra_a_conta_do_pai

    expect(page).to have_content 'Caderneta de Felipe'

    click_link 'Pessoas'

    expect(page).to have_content 'Titular da conta'
    expect(page).to have_content 'pai@example.com'

    click_link 'Cadastrar pessoa'

    fill_in 'Nome', with: 'Joãozinho'
    fill_in 'Data de nascimento', with: '01/03/2025'
    fill_in 'E-mail', with: 'joaozinho@example.com'
    attach_file 'Foto', Rails.root.join('spec/fixtures/files/foto.png')
    click_button 'Criar Pessoa'

    expect(page).to have_content 'Joãozinho entrou na conta e já tem uma caderneta.'
    expect(page).to have_css("img.avatar[alt='Joãozinho']")

    click_link 'Caderneta'
    expect(page).to have_content 'Caderneta de Joãozinho'

    click_link 'Calendário'
    expect(page).to have_content 'Situação de cada vacina do calendário para a idade de Joãozinho.'

    joaozinho = Pessoa.find_by!(nome: 'Joãozinho')
    expect(joaozinho.foto).to be_attached
    expect(joaozinho.caderneta.recomendacao_vacinas.count).to eq(17)
    expect(joaozinho.user.pessoas.count).to eq(2)

    click_link 'Pessoas'

    within('tr', text: 'Felipe') { click_button 'Ver caderneta' }

    expect(page).to have_content 'Você está vendo a caderneta de Felipe.'

    click_link 'Caderneta'
    expect(page).to have_content 'Caderneta de Felipe'

    click_link 'Pessoas'

    within('tr', text: 'Felipe') { expect(page).to have_no_button 'Excluir' }
    within('tr', text: 'Joãozinho') { click_button 'Excluir' }

    expect(page).to have_content 'Joãozinho e a caderneta dela foram excluídas.'
    expect(page).to have_no_content 'joaozinho@example.com'
    expect(Pessoa.where(nome: 'Joãozinho')).to be_empty
  end

  def cadastra_a_conta_do_pai
    visit '/users/sign_up'

    within('#new_user') do
      fill_in 'E-mail', with: 'pai@example.com'
      fill_in 'Seu nome', with: 'Felipe'
      fill_in 'Sua data de nascimento', with: '01/01/1990'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_button 'Cadastrar'
    end
  end
end
