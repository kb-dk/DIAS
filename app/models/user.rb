class User < ActiveRecord::Base
# Connects this user object to Hydra behaviors. 
 include Hydra::User

 include CanCan::Ability
# Connects this user object to Blacklights Bookmarks. 
 include Blacklight::User
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body


  ROLES = %w[admin depositor guest]


  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account. 
  def to_s
    email + ' ' + admin?.to_s
  end


  def admin?
   email === 'jac@kb.dk'
  end

  def depositor?
    return :email.to_s.index('@ku.dk')
  end



end
