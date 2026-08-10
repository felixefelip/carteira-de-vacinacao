class Current < ActiveSupport::CurrentAttributes
  attribute :user, :pessoa, :caderneta

  # Quem manda na caderneta em foco é a pessoa ativa, não a conta: uma conta
  # administra várias pessoas e alterna entre elas.
  def pessoa=(value)
    super(value)

    unless value.nil?
      self.caderneta = value.caderneta
    end
  end
end
