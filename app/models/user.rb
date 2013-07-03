class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users
  include BCrypt

  # before_save :encrypt_password
  
  attr_accessor :entered_password

  # before :valid?, :check_password_length
  validates_uniqueness_of :email
  validates_presence_of :name, :email, :password_hash
  validates :entered_password, length: {minimum: 6 }

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.entered_password = new_password
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user
      user.password == password
    else
      false
    end

  end

  # def check_password_length
  #   @password.length 
  # end

end
