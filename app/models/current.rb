class Current < ActiveSupport::CurrentAttributes
  def self.user!
    @@user
  end

  def self.user=(user)
    @@user = user
  end

  def self.caderneta!
    user!.caderneta!
  end
end
