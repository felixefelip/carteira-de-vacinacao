class Current < ActiveSupport::CurrentAttributes
  attribute :user, :pessoa, :caderneta

  def pessoa=(value)
    super(value)

    unless value.nil?
      self.caderneta = value.caderneta
    end
  end
end
