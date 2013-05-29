class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, :scope => :last_name
  validates_uniqueness_of :email, :case_sensitive => false

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
end
