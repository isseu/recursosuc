class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Redirects to login for secure resources
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      flash[:alert] = "No estas autorizado para ver esta pagina"
      session[:user_return_to] = nil
      redirect_to root_url

    else
      flash[:alert] = "Debes ingresar primero para ver esta pagina"
      session[:user_return_to] = request.url
      redirect_to "/users/sign_in"
    end
  end
end
