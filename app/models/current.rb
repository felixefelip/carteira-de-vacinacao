class Current < ActiveSupport::CurrentAttributes
  attribute :user, :caderneta

  def user=(value)
    super(value)

    unless value.nil?
      self.caderneta = value.caderneta
    end
  end
end
