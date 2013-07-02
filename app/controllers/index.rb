# require 'sessions'
enable :sessions

get '/' do
  # render home page
 #TODO: Show all users if user is signed in
  @all_users = all_users
  @user = current_user
  puts "All user: #{@all_users}"
  puts "User: #{@user}"
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  # sign-in
  email = params[:email]
  password = params[:password]
  @user = User.authenticate(email, password)
  if @user
    session[:user_id] = @user.id
  end
  @all_users = all_users
  # puts "Params: #{params}"
  erb :index
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  if request.xhr?
    content_type = :json
  end

end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users/create' do
  # sign-up a new user
  @user = User.create(params[:user])
  # @user.password = params[:user][:password])
  session[:user_id] = @user.id
  erb :index

end
