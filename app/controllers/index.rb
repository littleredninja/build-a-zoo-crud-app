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
			redirect ('/')
		end
end

post '/users/new' do 
	new_user = User.new(params[:user])
	if new_user.save
		session[:user_id] = new_user.id
		redirect ('/zoos')
	else
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

