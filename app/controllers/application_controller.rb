# typed: true

class ApplicationController < ActionController::Base
  extend T::Sig

  before_action :authenticate_user!
  before_action :set_authenticated_user

  private

  sig { void }
  def set_authenticated_user
    Current.user = current_user
  end
end
