class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_action :authenticate

  #Este metodo autentificara a un usuario con el token correcto
  def authenticate
  	authenticate_or_request_with_http_token do |token, options|
      if params[:user][:login].to_s.include? "@"
        user = User.find_by_mail(params[:user][:login])
      else
        user = User.find_by_name(params[:user][:login])
      end
    	if user.validate(token)
    		@user = user
    	end
    end  	
  end
end
