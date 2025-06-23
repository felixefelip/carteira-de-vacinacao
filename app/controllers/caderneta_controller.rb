# typed: true

class CadernetaController < ApplicationController
  extend T::Sig

  def index
    @vacinas = vacinas
    render Views::Caderneta::Index.new(vacinas: @vacinas)
  end

  def show
    render Views::Caderneta::Show.new(vacina:, fabricante_vacinas:)
  end

  private

  #: -> Vacina
  def vacina
    @vacina ||= Vacina.find(params[:id])
  end

  #: -> Vacina::PrivateAssociationRelation
  def vacinas
    Current.caderneta!.vacinas.distinct
  end

  #: -> FabricanteVacina::PrivateAssociationRelation
  def fabricante_vacinas
    vacina.fabricante_vacinas.joins(:doses).where('doses.caderneta_id = ? ', Current.caderneta!.id).distinct
  end
end
