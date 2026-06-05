class Current < ActiveSupport::CurrentAttributes
  attribute :user, :caderneta

  def user=(value)
    super(value)

    if value.present?
      self.caderneta = value.caderneta
    end
  end
end
