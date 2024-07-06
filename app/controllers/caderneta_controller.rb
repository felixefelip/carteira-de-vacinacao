# typed: true

class CadernetaController < ApplicationController
  extend T::Sig

  def index
    @vacinas = current_user.vacinas.uniq
  end

  def show
    @fabricante_vacinas = vacina.fabricante_vacinas.joins(:doses).where('doses.user_id = ? ', current_user.id).uniq
  end

  sig { returns(Vacina::Record) }
  def vacina
    @vacina ||= Vacina::Record.find(params[:id])
  end
end
