class User::UsersController < ApplicationController
  skip_before_action  :authenticate, only: [:index, :show, :create]
  before_action       :set_user, only: [:show]

  #Se retorna un .json con todos los usuarios
  def index
  	@users = User.all

    respond_to do |format|      
      format.json { render json: @users }
    end
  end

  #Dado un usuario se debe retornar un .json con los datos del usuario y sus mashups  
  def show        
    respond_to do |format|      
      format.json { render json: @user.as_json(include: {mashups: {}})}
    end
  end

  #Se sobrescribe, esto genera un usuario
  def create
  	
  end

  #Se sobrescribe, esto edita un usuario
  def update
  	
  end

  #Borra un usuario
  def destroy    
    @user.destroy
    respond_to do |format|        
        format.json { head :no_content }
      end
  end

  private
      def set_user
        @user = User.find(params[:id])
      end

end
