class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
 #load_and_authorize_resource

  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end
end
