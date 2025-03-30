# typed: true

class ApplicationController < ActionController::Base
  extend T::Sig

  before_action :authenticate_user!

  sig { returns(User::Record) }
  def current_user!
    current_user
  end
end
