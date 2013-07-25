class User < ActiveRecord::Base
  attr_accessible :email, :name, :photo, :major, :password, :password_confirmation

  #profile photo
  #attr_accessor :photo
  #attr_accessor :photo_file_name
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"

  has_secure_password


  before_save { email.downcase! } #does this need { }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 } 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_UMICH_EMAIL = /\A[\w+\-.]+@umich.edu/i
  validates :email, presence: true, 
  					#format: { with: VALID_UMICH_EMAIL },
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end


end
