helpers do
  # include BCrypt

  def current_user
    # TODO: return the current user if there is a user signed in.
    # current ||= User.find()
    if session[:user]
      @current_user ||= User.find(sessions[:user])
    end
  end

  def logged_in?
    !current_user.nil?
  end


  # def login
  #   @user = User.find_by_email(params[:email])
  #   if @user.password == params[:password]
  #     # give_token
  #   else
  #     # redirect_to home_url
  #   end
  # end

  def all_users
    # User.pluck(:name)
    User.all
  end

  # def forgot_password
  #   @user = User.find_by_email(params[:email])
  #   random_password = Array.new(10).map { (65 + rand(58)).chr }.join
  #   @user.password = random_password
  #   @user.save!
  #   Mailer.create_and_deliver_password_change(@user, random_password)
  # end

end
