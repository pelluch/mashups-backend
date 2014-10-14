class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate

  #Este metodo autentificara a un usuario con el token correcto
  def authenticate
  	authenticate_or_request_with_http_token do |token, options|
    	user = User.find(params[:id])
    	if User.validate(token)
    		@user = user
    	end
    end  	
  end
end
