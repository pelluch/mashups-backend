class User::UsersNormalController < User::UsersController
  
  #Generar una cuenta normal
  def create
	@user = User.new(user_params)

  	respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #Actualizar una cuenta normal
  def update
    params[:user].delete(:password) if params[:user][:password].blank?
  	respond_to do |format|
      if @user.update(user_params)
        format.json { render json: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	  	
  end

  private
  	def user_params
      params.require(:user).permit(:name, :mail, :password)
    end
  
end