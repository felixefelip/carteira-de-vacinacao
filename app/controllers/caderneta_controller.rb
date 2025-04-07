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

  sig { returns(Vacina) }
  def vacina
    @vacina ||= Vacina.find(params[:id])
  end

  T::Sig::WithoutRuntime.sig { returns(Vacina::PrivateAssociationRelation) }
  def vacinas
    Current.user!.vacinas.distinct
  end

  T::Sig::WithoutRuntime.sig { returns(FabricanteVacina::PrivateAssociationRelation) }
  def fabricante_vacinas
    vacina.fabricante_vacinas.joins(:doses).where('doses.user_id = ? ', current_user.id).distinct
  end
end
