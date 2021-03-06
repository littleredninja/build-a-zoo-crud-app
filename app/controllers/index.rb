get '/' do 
	@users = User.all
	erb :index
end

post '/sessions' do
	@user = User.find_by(email: params[:email])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect ('/zoos')
		else
			@error = "So sad, can't sign in.  Please try again."
			erb :index
		end
end

post '/users/new' do 
	new_user = User.new(params[:user])
	if new_user.save
		session[:user_id] = new_user.id
		redirect ('/zoos')
	else
		@error = "I'm sorry, something went wrong!  Please try again."
		redirect ('/')
	end
end

get '/zoos' do
	@user = User.find(session[:user_id])
	erb :zoos
end

get '/zoos/new' do
	erb :new_zoo
end

post '/zoos/new' do
	@user = User.find(session[:user_id])
	new_zoo = Zoo.create(name: params[:name], location: params[:location], zookeeper_id: @user.id)
	redirect ('/zoos')
end

get '/zoos/:zoo_id/edit' do
	find_current_zoo
	erb :edit_zoo
end

put '/zoos/:zoo_id/edit' do
	find_current_zoo
	@zoo.update(params[:zoo])
	redirect ('/zoos')
end

delete '/zoos/:zoo_id' do
	find_current_zoo
	@zoo.destroy
	redirect('/zoos')
end

get '/zoos/:zoo_id/animals/new' do
	find_current_zoo
	erb :"zoo_animals_add"
end

get '/zoos/:zoo_id/animals' do
	find_current_zoo
	@animals = @zoo.animals
	erb :zoo_animals
end

post '/zoos/:zoo_id/animals' do
	find_current_zoo
	new_animal = Animal.create(params[:animal])
	new_animal.update(zoo: @zoo)
	redirect ("/zoos/#{@zoo.id}/animals")
end

get '/animal/:animal_id/edit' do
	find_current_animal
	erb :zoo_animals_edit
end

put '/animal/:animal_id/edit' do
	find_current_animal
	@zoo = @animal.zoo
	@animal.update(params[:animal])
	redirect ("/zoos/#{@zoo.id}/animals")
end

delete '/animal/:animal_id/delete' do
	find_current_animal
	@zoo = @animal.zoo
	@animal.destroy
	redirect ("/zoos/#{@zoo.id}/animals") 
end

get "/logout" do
	session[:user_id] =  nil 
	erb :index
end





	private

	# def require_login
	# 	unless logged_in?
	# 		@error = "You must be logged in to access this section"
	# 		puts "hi mom"
	# 	end
	# end
