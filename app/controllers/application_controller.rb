class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_action :authenticate

  #Este metodo autentificara a un usuario con el token correcto
  def authenticate
  	authenticate_or_request_with_http_token do |token, options|
      if params[:id] != nil
        user = User.find(params[:id])
        puts user.name
      elsif params[:login].to_s.include? "@"
        user = User.find_by_mail(params[:login])
      else
        user = User.find_by_name(params[:login])
      end
      puts user.name
      if user == nil
        false
    	elsif user.validate(token)
    		@user = user
    	end
    end  	
  end

  def get_user
    if params[:login].to_s.include? "@"
        @user = User.find_by_mail(params[:login])
    else
        @user = User.find_by_name(params[:login])
    end     
  end

end
