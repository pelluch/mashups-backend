class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #protect_from_forgery with: :exception
  before_action :authenticate

  #Este metodo autentificara a un usuario con el token correcto
  def authenticate
  	authenticate_or_request_with_http_token do |token, options|
      begin
        if params[:controller] == 'user/users' || params[:controller] == 'user/user_normal'
          if params[:id]
            user = User.find(params[:id])
            puts user.name
          end
        else
          if params[:user_id]
            user = User.find(params[:user_id])
          end  
        end
        if user != nil

        elsif params[:login].include? "@"
          user = User.find_by_mail(params[:login])
        else
          user = User.find_by_name(params[:login])
        end

        if user == nil 
          false
        elsif user.validate(token)
          @user = user
        end
      rescue Exception => e
        answer = Array.new
        answer << 'Usuario no existe'
        respond_to do |format|
          format.json { render json: answer.as_json}
        end
      end      
    end  	
  end

  def get_user
    begin
      if params[:user_id]
        @user = User.find(params[:user_id])
      elsif params[:login].include? "@"
        @user = User.find_by_mail(params[:login])
      else
        @user = User.find_by_name(params[:login])
      end     
    rescue
      answer = Array.new
      answer << 'Usuario no existe'
      respond_to do |format|
        format.json { render json: answer.as_json}
      end
    end
  end

end
