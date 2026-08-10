class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_authenticated_user

  private

  def set_authenticated_user
    Current.user = current_user
    Current.pessoa = pessoa_ativa
  end

  # A conta administra várias pessoas e vê uma de cada vez. A escolha vive na
  # sessão e é sempre reencontrada dentro da própria conta — id de sessão
  # apontando para pessoa de outra conta simplesmente não resolve.
  def pessoa_ativa
    return if current_user.nil?

    current_user.pessoas.find_by(id: session[:pessoa_id]) || current_user.pessoa_titular
  end
end
