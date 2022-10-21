class CadernetaController < ApplicationController
  def index
    @vacinas = current_user.vacinas
  end
end
