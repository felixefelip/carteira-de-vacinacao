# typed: true

class CadernetaController < ApplicationController
  extend T::Sig

  def index
    @vacinas = vacinas
    render Views::Caderneta::Index.new(vacinas: @vacinas)
  end

  def show
    @fabricante_vacinas = fabricante_vacinas
  end

  private

  sig { returns(Vacina::Record) }
  def vacina
    @vacina ||= Vacina::Record.find(params[:id])
  end

  sig { returns(ActiveRecord::Relation) }
  def vacinas
    current_user!.vacinas.distinct
  end

  sig { returns(ActiveRecord::Relation) }
  def fabricante_vacinas
    vacina.fabricante_vacinas.joins(:doses).where('doses.user_id = ? ', current_user.id).distinct
  end
end
