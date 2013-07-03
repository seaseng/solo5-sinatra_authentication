# require 'sessions'
enable :sessions

get '/' do
  # session.clear
  # render home page
 #TODO: Show all users if user is signed in
  @all_users = all_users
  @user = current_user
  # puts "All user: #{@all_users}"
  # puts "User: #{@user}"
  puts "Session User: #{session[:user]}" if session[:user]
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  @all_users = all_users
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @all_users = all_users
  email = params[:email]
  password = params[:password]
  if User.authenticate(email, password)
    @user = User.find_by_email(email)
  end

  # debugger
  # ''

  if @user
    session[:user] = @user.id
    redirect '/'
  else
    erb :failed_login
  end
  
  # puts "Params: #{params}"
  
end


delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  if request.xhr?
    content_type = :json
    session.clear
  end

end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users/create' do
  # sign-up a new user
  @all_users = all_users


  @user = User.create(params[:user])

  # debugger

  if @user.valid?
    session[:user] = @user.id
    puts "Session User: #{session[:user]}"
    puts "User ID: #{@user.id}"
    erb :index
  else
    puts "Errors: #{@user.errors}"
    erb :failed_login
  end
  # debugger

  
end
