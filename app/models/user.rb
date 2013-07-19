class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  validates :name, presence: true, length: { maximum: 50 } 
  VALID_UMICH_EMAIL = /\A[\w+\-.]+@umich.edu/i
  validates :email, presence: true, 
  					format: { with: VALID_UMICH_EMAIL },
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


end
