class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_authenticated_user

  private

  def set_authenticated_user
    Current.user = current_user
    Current.pessoa = pessoa_ativa
  end

  def pessoa_ativa
    return if current_user.nil?

    current_user.pessoas.find_by(id: session[:pessoa_id]) || current_user.pessoa_titular
  end
end
