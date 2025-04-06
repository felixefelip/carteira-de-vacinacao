# typed: true

class Current < ActiveSupport::CurrentAttributes
  extend T::Sig

  sig { returns(User) }
  def self.user!
    @@user
  end

  sig { params(user: T.nilable(User)).void }
  def self.user=(user)
    @@user = user
  end
end
