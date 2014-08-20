helpers do 


	def find_current_zoo
		@zoo = Zoo.find(params[:zoo_id])
	end

	def find_current_animal
		@animal = Animal.find(params[:animal_id])
	end

	# def current_user

	# @user ||= User.find(session[:user_id]) if session[:user_id]
# end

end
