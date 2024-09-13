# typed: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_user
    User::Record.find(session['warden.user.user.key']['id'])
  end
end
