class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def self.caderneta
    user.caderneta
  end
end
