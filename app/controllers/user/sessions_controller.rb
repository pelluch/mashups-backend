class User::SessionsController < ApplicationController
	#Metodos abstractos, la implementación debe definirse en los metodos en las clases que heredan
	skip_before_action :authenticate
	
	def create

	end

	def destroy

	end 

end
