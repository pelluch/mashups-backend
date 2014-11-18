class User::SessionsFacebookController < User::SessionsController
 
	def home
		
	end

	def new
  		redirect_to '/user/auth/facebook'
	end	
	#Se debe generar y retornar un token para la sesion
	def create		
		# raise request.env["omniauth.auth"].to_yaml
		
		# user = User.from_omniauth(env['omniauth.auth'])
		auth = request.env["omniauth.auth"]
		user = User.where(:provider => auth['provider'], 
		                :uid => auth['uid']).first || User.create_with_omniauth(auth)
		
		#borrar
		session[:user_id] = user.id		
		redirect_to root_url, :notice => "Signed in!"
	end

	#Se elimina el token para terminar la sesion
	def destroy
		reset_session
  		
  		#borrar
  		redirect_to root_url, notice => 'Signed out'
	end 

end