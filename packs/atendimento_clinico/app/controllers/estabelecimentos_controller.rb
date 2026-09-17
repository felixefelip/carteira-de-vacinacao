class EstabelecimentosController < ApplicationController
  before_action :set_estabelecimento, only: %i[edit update]

  def index
    @estabelecimentos = Estabelecimento.order(:nome)
  end

  def new
    @estabelecimento = Estabelecimento.new
  end

  def edit; end

  def create
    @estabelecimento = Estabelecimento.new(estabelecimento_params)

    if @estabelecimento.save
      redirect_to estabelecimentos_path, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @estabelecimento.update(estabelecimento_params)
      redirect_to estabelecimentos_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_estabelecimento
    @estabelecimento = Estabelecimento.find(params.expect(:id))
  end

  def estabelecimento_params
    params.expect(estabelecimento: [:nome])
  end
end
