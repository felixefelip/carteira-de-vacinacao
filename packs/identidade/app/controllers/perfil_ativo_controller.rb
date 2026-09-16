class PerfilAtivoController < ApplicationController
  def update
    pessoa = current_user.pessoas.find(params.expect(:pessoa_id))
    session[:pessoa_id] = pessoa.id

    redirect_back_or_to caderneta_path, notice: "Você está vendo a caderneta de #{pessoa.nome}."
  end
end
