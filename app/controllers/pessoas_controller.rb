class PessoasController < ApplicationController
  before_action :set_pessoa, only: %i[edit update destroy]

  def index
    @pessoas = current_user.pessoas.por_nome.with_attached_foto
  end

  def new
    @pessoa = current_user.pessoas.build
  end

  def edit; end

  def create
    @pessoa = current_user.pessoas.build(pessoa_params)

    if @pessoa.save
      session[:pessoa_id] = @pessoa.id
      redirect_to pessoas_path, notice: "#{@pessoa.nome} entrou na conta e já tem uma caderneta."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @pessoa.update(pessoa_params)
      redirect_to pessoas_path, notice: "Os dados de #{@pessoa.nome} foram atualizados."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    return redirect_to pessoas_path, alert: 'A pessoa titular da conta não pode ser excluída.' if @pessoa.titular?

    @pessoa.destroy!
    session.delete(:pessoa_id) if session[:pessoa_id] == @pessoa.id

    redirect_to pessoas_path, notice: "#{@pessoa.nome} e a caderneta dela foram excluídas."
  end

  private

  def set_pessoa
    @pessoa = current_user.pessoas.find(params.expect(:id))
  end

  # O e-mail da pessoa titular é o da conta, e muda no cadastro da conta —
  # o formulário daqui não tem esse campo para ela.
  def pessoa_params
    permitidos = params.expect(pessoa: %i[nome data_nascimento email foto])

    @pessoa&.titular? ? permitidos.except(:email) : permitidos
  end
end
