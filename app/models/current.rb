# typed: true

class Current < ActiveSupport::CurrentAttributes
  extend T::Sig

  #: -> User
  def self.user!
    @@user
  end

  #: (User?) -> void
  def self.user=(user)
    @@user = user
  end

  #: -> User::Caderneta
  def self.caderneta!
    user!.caderneta!
  end
end
