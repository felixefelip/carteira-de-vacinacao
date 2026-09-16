class VacinacaoController < ApplicationController
  helper_method :caderneta_ativa

  private

  def caderneta_ativa
    Current.pessoa.caderneta
  end
end
